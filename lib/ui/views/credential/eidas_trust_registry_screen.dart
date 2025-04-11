import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/ui/common/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Écran pour interagir avec le registre de confiance européen
class EidasTrustRegistryScreen extends ConsumerStatefulWidget {
  const EidasTrustRegistryScreen({super.key});

  @override
  ConsumerState<EidasTrustRegistryScreen> createState() =>
      _EidasTrustRegistryScreenState();
}

class _EidasTrustRegistryScreenState
    extends ConsumerState<EidasTrustRegistryScreen> {
  bool _isVerifyingIssuer = false;
  String? _issuerToVerify;
  Map<String, dynamic>? _verificationResult;
  bool _isLoadingSchemes = false;
  Map<String, dynamic>? _trustSchemes;

  @override
  void initState() {
    super.initState();
    _loadTrustSchemes();
  }

  Future<void> _loadTrustSchemes() async {
    setState(() {
      _isLoadingSchemes = true;
    });

    try {
      final schemes =
          await ref.read(eidasNotifierProvider.notifier).fetchTrustSchemes();
      setState(() {
        _trustSchemes = schemes;
        _isLoadingSchemes = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingSchemes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eidasState = ref.watch(eidasNotifierProvider);
    final trustedIssuers = eidasState.trustedIssuers;
    final trustListReport = eidasState.trustListReport;
    final interopReport = eidasState.interoperabilityReport;
    final lastSyncDate = eidasState.lastSyncDate;
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.eidasTrustRegistryTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(eidasNotifierProvider.notifier).loadTrustList();
            },
            tooltip: l10n.refreshRegistryTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: l10n.aboutRegistryTooltip,
          ),
        ],
      ),
      body: eidasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _synchronizeWithEuRegistry,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bandeau d'information sur le registre
                    _EidasTrustInfoBanner(l10n: l10n),

                    if (eidasState.errorMessage != null)
                      _buildErrorMessage(eidasState.errorMessage!),

                    // Section synchro
                    _buildSyncStatusCard(lastSyncDate, dateFormat, l10n),

                    const SizedBox(height: 16),

                    // Section pour vérifier un émetteur
                    _buildIssuerVerificationCard(l10n),

                    const SizedBox(height: 16),

                    // Section rapport de liste de confiance
                    if (trustListReport != null)
                      _buildTrustListReportCard(trustListReport, l10n),

                    const SizedBox(height: 16),

                    // Section schémas de confiance
                    _buildTrustSchemesCard(l10n),

                    const SizedBox(height: 16),

                    // Section interopérabilité
                    if (interopReport != null)
                      _buildInteropReportCard(interopReport, l10n),

                    const SizedBox(height: 16),

                    // Section filtres
                    _buildFilterCard(eidasState, l10n),

                    const SizedBox(height: 16),

                    // Liste des émetteurs
                    _buildTrustedIssuersList(trustedIssuers, l10n),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildErrorMessage(String errorMessage) {
    return Card(
      color: Colors.red.shade100,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatusCard(
    DateTime? lastSyncDate,
    DateFormat dateFormat,
    AppLocalizations l10n,
  ) {
    return AppCard(
      title: l10n.lastSynchronization,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(l10n.lastSynchronization),
            subtitle: Text(
              lastSyncDate != null
                  ? dateFormat.format(lastSyncDate)
                  : l10n.neverSynchronized,
            ),
            trailing: const Icon(Icons.access_time),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.sync),
              label: Text(l10n.synchronizeWithEuRegistry),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _synchronizeWithEuRegistry,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuerVerificationCard(AppLocalizations l10n) {
    return AppCard(
      title: l10n.verifyIssuerTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.issuerIdentifierHint,
                hintText: l10n.issuerIdentifierExample,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _issuerToVerify = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.verified_user),
              label: Text(l10n.verifyInRegistryButton),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _issuerToVerify?.isNotEmpty == true
                  ? () => _verifyIssuer(_issuerToVerify!)
                  : null,
            ),
          ),
          if (_isVerifyingIssuer)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_verificationResult != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.verificationResultTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _verificationResult!['isValid'] == true
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _verificationResult!['isValid'] == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _verificationResult!['isValid'] == true
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: _verificationResult!['isValid'] == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _verificationResult!['isValid'] == true
                                  ? l10n.verifiedIssuer
                                  : l10n.unrecognizedIssuer,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _verificationResult!['isValid'] == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_verificationResult!['verification'] != null) ...[
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            '${l10n.verificationStatus}: ${_verificationResult!['verification']['status']}',
                          ),
                          if (_verificationResult!['verification']
                                  ['timestamp'] !=
                              null)
                            Text(
                              '${l10n.verificationTimestamp}: ${_verificationResult!['verification']['timestamp']}',
                            ),
                          if (_verificationResult!['verification']
                                  ['trustLevel'] !=
                              null)
                            Text(
                              '${l10n.verificationTrustLevel}: ${_verificationResult!['verification']['trustLevel']}',
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrustListReportCard(
    Map<String, dynamic> report,
    AppLocalizations l10n,
  ) {
    return AppCard(
      title: l10n.trustListReportTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportItem(
              icon: Icons.verified_user,
              label: l10n.trustedIssuers,
              value: report['trustedIssuersCount']?.toString() ?? '-',
            ),
            const Divider(),
            _buildReportItem(
              icon: Icons.flag,
              label: l10n.countriesRepresented,
              value: report['countriesRepresentedCount']?.toString() ?? '-',
            ),
            const Divider(),
            _buildReportItem(
              icon: Icons.category,
              label: l10n.serviceTypes,
              value: report['serviceTypesCount']?.toString() ?? '-',
            ),
            if (report['trustLevelCounts'] != null) ...[
              const Divider(),
              _buildTrustLevelStats(report['trustLevelCounts'], l10n),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  Widget _buildTrustLevelStats(
    Map<String, dynamic> trustLevelCounts,
    AppLocalizations l10n,
  ) {
    final total = (trustLevelCounts['low'] ?? 0) +
        (trustLevelCounts['substantial'] ?? 0) +
        (trustLevelCounts['high'] ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                l10n.trustLevelDistribution,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (total > 0) ...[
          _buildTrustLevelBar(
            l10n.high,
            Colors.green,
            (trustLevelCounts['high'] ?? 0) / total,
            '${trustLevelCounts['high'] ?? 0}',
          ),
          const SizedBox(height: 4),
          _buildTrustLevelBar(
            l10n.substantial,
            Colors.blue,
            (trustLevelCounts['substantial'] ?? 0) / total,
            '${trustLevelCounts['substantial'] ?? 0}',
          ),
          const SizedBox(height: 4),
          _buildTrustLevelBar(
            l10n.low,
            Colors.amber,
            (trustLevelCounts['low'] ?? 0) / total,
            '${trustLevelCounts['low'] ?? 0}',
          ),
        ],
      ],
    );
  }

  Widget _buildTrustLevelBar(
    String label,
    Color color,
    double percentage,
    String count,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 50, child: Text(count, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildTrustSchemesCard(AppLocalizations l10n) {
    return AppCard(
      title: l10n.trustSchemesTitle,
      child: _isLoadingSchemes
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            )
          : _trustSchemes == null ||
                  (_trustSchemes?['schemes'] as List?)?.isEmpty == true
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l10n.noTrustSchemesAvailable),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (_trustSchemes?['schemes'] as List?)?.length ?? 0,
                  itemBuilder: (context, index) {
                    final scheme = (_trustSchemes!['schemes'] as List)[index];
                    return ExpansionTile(
                      title: Text(scheme['name']),
                      subtitle: Text('ID: ${scheme['id']}'),
                      leading: Icon(
                        Icons.security,
                        color: scheme['id'].toString().contains('high')
                            ? Colors.green
                            : scheme['id'].toString().contains('substantial')
                                ? Colors.blue
                                : Colors.amber,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(scheme['description']),
                              const SizedBox(height: 8),
                              if (scheme['requirements'] != null) ...[
                                Text(
                                  l10n.requirementsLabel,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...List.generate(
                                  (scheme['requirements'] as List).length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('• '),
                                        Expanded(
                                          child: Text(
                                            (scheme['requirements'] as List)[i],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
    );
  }

  Widget _buildInteropReportCard(
    Map<String, dynamic> report,
    AppLocalizations l10n,
  ) {
    return AppCard(
      title: l10n.interopReportTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportItem(
              icon: report['status'] == 'OK' ? Icons.check_circle : Icons.error,
              label: l10n.status,
              value: report['status']?.toString() ?? '-',
            ),
            if (report['timestamp'] != null) ...[
              const Divider(),
              _buildReportItem(
                icon: Icons.access_time,
                label: l10n.timestamp,
                value: report['timestamp'] != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(DateTime.parse(report['timestamp']))
                    : '-',
              ),
            ],
            if (report['totalTrustedIssuers'] != null) ...[
              const Divider(),
              _buildReportItem(
                icon: Icons.verified_user,
                label: l10n.trustedIssuers,
                value: report['trustedIssuersCount']?.toString() ?? '-',
              ),
            ],
            if (report['issuersByCountry'] != null) ...[
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  l10n.countryDistribution,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...List.generate(
                (report['issuersByCountry'] as Map).length,
                (i) {
                  final entry =
                      (report['issuersByCountry'] as Map).entries.elementAt(i);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('${entry.value}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard(EidasState state, AppLocalizations l10n) {
    return AppCard(
      title: l10n.filtersTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.filterByTrustLevel),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTrustLevelFilterChip(
                  l10n.all,
                  null,
                  state.selectedTrustLevel,
                ),
                const SizedBox(width: 8),
                _buildTrustLevelFilterChip(
                  l10n.high,
                  TrustLevel.high,
                  state.selectedTrustLevel,
                ),
                const SizedBox(width: 8),
                _buildTrustLevelFilterChip(
                  l10n.substantial,
                  TrustLevel.substantial,
                  state.selectedTrustLevel,
                ),
                const SizedBox(width: 8),
                _buildTrustLevelFilterChip(
                  l10n.low,
                  TrustLevel.low,
                  state.selectedTrustLevel,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.filterByCountry),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCountryFilterChip(
                    l10n.all,
                    null,
                    state.selectedCountry,
                  ),
                  const SizedBox(width: 8),
                  _buildCountryFilterChip(
                    l10n.eu,
                    'EU',
                    state.selectedCountry,
                  ),
                  const SizedBox(width: 8),
                  _buildCountryFilterChip(
                    l10n.france,
                    'FR',
                    state.selectedCountry,
                  ),
                  const SizedBox(width: 8),
                  _buildCountryFilterChip(
                    l10n.germany,
                    'DE',
                    state.selectedCountry,
                  ),
                  const SizedBox(width: 8),
                  _buildCountryFilterChip(
                    l10n.italy,
                    'IT',
                    state.selectedCountry,
                  ),
                  const SizedBox(width: 8),
                  _buildCountryFilterChip(
                    l10n.spain,
                    'ES',
                    state.selectedCountry,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustLevelFilterChip(
    String label,
    TrustLevel? level,
    TrustLevel? selectedLevel,
  ) {
    return FilterChip(
      label: Text(label),
      selected: level == selectedLevel,
      onSelected: (selected) {
        ref
            .read(eidasNotifierProvider.notifier)
            .filterIssuersByTrustLevel(selected ? level : null);
      },
    );
  }

  Widget _buildCountryFilterChip(
    String label,
    String? countryCode,
    String? selectedCountry,
  ) {
    return FilterChip(
      label: Text(label),
      selected: countryCode == selectedCountry,
      onSelected: (selected) {
        ref
            .read(eidasNotifierProvider.notifier)
            .filterIssuersByCountry(selected ? countryCode : null);
      },
    );
  }

  Widget _buildTrustedIssuersList(
    List<TrustedIssuer> issuers,
    AppLocalizations l10n,
  ) {
    return AppCard(
      title: '${l10n.trustedIssuersTitle} (${issuers.length})',
      child: issuers.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(l10n.noTrustedIssuersFound),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: issuers.length,
              itemBuilder: (context, index) {
                final issuer = issuers[index];
                final color = issuer.trustLevel == TrustLevel.high
                    ? Colors.green
                    : issuer.trustLevel == TrustLevel.substantial
                        ? Colors.blue
                        : Colors.amber;
                return ListTile(
                  title: Text(issuer.name),
                  subtitle: Text(
                    '${issuer.country} • ${issuer.serviceType}\nDID: ${issuer.did}',
                  ),
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.2),
                    child: Icon(Icons.verified_user, color: color),
                  ),
                  trailing: Chip(
                    label: Text(
                      issuer.trustLevel == TrustLevel.high
                          ? l10n.high
                          : issuer.trustLevel == TrustLevel.substantial
                              ? l10n.substantial
                              : l10n.low,
                    ),
                    backgroundColor: color.withValues(alpha: 0.2),
                    labelStyle: TextStyle(color: color),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(issuer.name),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${l10n.countryLabel}: ${issuer.country}'),
                            Text(
                              '${l10n.serviceTypeLabel}: ${issuer.serviceType}',
                            ),
                            Text('${l10n.didLabel}: ${issuer.did}'),
                            Text(
                              '${l10n.trustLevelLabel}: ${issuer.trustLevel.name}',
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(l10n.comprehendButton),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Future<void> _synchronizeWithEuRegistry() async {
    await ref
        .read(eidasNotifierProvider.notifier)
        .synchronizeWithEidasInfrastructure();
  }

  Future<void> _verifyIssuer(String issuerId) async {
    setState(() {
      _isVerifyingIssuer = true;
      _verificationResult = null;
    });

    try {
      final result = await ref
          .read(eidasNotifierProvider.notifier)
          .verifyTrustedIssuer(issuerId);
      setState(() {
        _verificationResult = result;
        _isVerifyingIssuer = false;
      });
    } catch (e) {
      setState(() {
        _verificationResult = {
          'isValid': false,
          'verification': {
            'status': 'ERROR',
            'error': e.toString(),
          },
        };
        _isVerifyingIssuer = false;
      });
    }
  }

  /// Affiche une information détaillée sur le registre de confiance eIDAS
  void _showInfoDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.aboutRegistryTitle),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.aboutRegistryDescription,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildInfoItem(l10n.security, l10n.securityDescription),
                const SizedBox(height: 12),
                _buildInfoItem(l10n.reliability, l10n.reliabilityDescription),
                const SizedBox(height: 12),
                _buildInfoItem(l10n.transparency, l10n.transparencyDescription),
                const SizedBox(height: 12),
                _buildInfoItem(
                  l10n.transfrontalier,
                  l10n.transfrontalierDescription,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Compris'),
            ),
          ],
        );
      },
    );
  }

  /// Construit un point d'information avec icône
  Widget _buildInfoItem(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.security, color: Colors.blue, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(content),
            ],
          ),
        ),
      ],
    );
  }
}

/// Bannière d'information sur le registre de confiance eIDAS
class _EidasTrustInfoBanner extends StatefulWidget {
  const _EidasTrustInfoBanner({required this.l10n});
  final AppLocalizations l10n;

  @override
  State<_EidasTrustInfoBanner> createState() => _EidasTrustInfoBannerState();
}

class _EidasTrustInfoBannerState extends State<_EidasTrustInfoBanner> {
  bool _dismissed = false;

  void dismiss() {
    setState(() {
      _dismissed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'À quoi sert ce registre ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    final bannerState = context
                        .findAncestorStateOfType<_EidasTrustInfoBannerState>();
                    bannerState?.dismiss();
                  },
                  tooltip: widget.l10n.closeButtonTooltip,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.l10n.eidasTrustRegistryDescription,
            ),
            const SizedBox(height: 8),
            Text(
              widget.l10n.searchByCountryOrService,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
