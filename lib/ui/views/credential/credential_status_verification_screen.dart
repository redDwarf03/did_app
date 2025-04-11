import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/infrastructure/credential/status_list_2021_service.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Écran de vérification du statut d'une attestation utilisant Status List 2021
class CredentialStatusVerificationScreen extends ConsumerStatefulWidget {
  const CredentialStatusVerificationScreen({
    super.key,
    required this.credentialId,
  });
  final String credentialId;

  @override
  ConsumerState<CredentialStatusVerificationScreen> createState() =>
      _CredentialStatusVerificationScreenState();
}

class _CredentialStatusVerificationScreenState
    extends ConsumerState<CredentialStatusVerificationScreen> {
  bool _isVerifying = false;
  StatusCheckResult? _statusResult;
  bool _showDetails = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _verifyCredentialStatus();
  }

  /// Vérifie le statut de l'attestation
  Future<void> _verifyCredentialStatus() async {
    setState(() {
      _isVerifying = true;
      _statusResult = null;
      _error = null;
    });

    try {
      final credentialAsync = await ref.read(
        credentialByIdProvider(widget.credentialId).future,
      );

      if (credentialAsync == null) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
            _statusResult = StatusCheckResult(
              credentialId: widget.credentialId,
              status: CredentialStatusType.unknown,
              checkedAt: DateTime.now(),
              error: 'Attestation non trouvée',
            );
          });
        }
        return;
      }

      // Vérifier le statut avec le service Status List 2021
      final statusService = ref.read(statusList2021ServiceProvider);
      final result = await statusService.checkCredentialStatus(credentialAsync);

      if (mounted) {
        setState(() {
          _isVerifying = false;
          _statusResult = result;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _statusResult = StatusCheckResult(
            credentialId: widget.credentialId,
            status: CredentialStatusType.unknown,
            checkedAt: DateTime.now(),
            error: 'Erreur lors de la vérification: $e',
          );
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final credentialAsync =
        ref.watch(credentialByIdProvider(widget.credentialId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verifyStatusTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refreshStatusTooltip,
            onPressed: _isVerifying ? null : _verifyCredentialStatus,
          ),
          IconButton(
            icon: Icon(_showDetails ? Icons.visibility_off : Icons.visibility),
            tooltip: _showDetails
                ? l10n.hideDetailsTooltip
                : l10n.showDetailsTooltip,
            onPressed: () {
              setState(() {
                _showDetails = !_showDetails;
              });
            },
          ),
        ],
      ),
      body: _isVerifying
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorView(l10n)
              : credentialAsync.when(
                  data: (credential) {
                    if (credential == null) {
                      return Center(
                        child: Text(l10n.credentialNotFound),
                      );
                    }

                    return _buildContent(context, credential, l10n);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text('${l10n.errorPrefix}: $error'),
                  ),
                ),
    );
  }

  Widget _buildErrorView(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.verificationError,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _verifyCredentialStatus,
            child: Text(l10n.retryButton),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Credential credential,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCredentialCard(credential, l10n),
          const SizedBox(height: 24),
          _buildStatusSection(l10n),
          if (_showDetails && _statusResult != null) ...[
            const SizedBox(height: 24),
            _buildTechnicalDetails(l10n),
          ],
          const SizedBox(height: 24),
          _buildStatusInfoCard(l10n),
        ],
      ),
    );
  }

  Widget _buildCredentialCard(Credential credential, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.credentialDetails),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getCredentialTypeIcon(credential.type),
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            credential.name ?? l10n.credentialType,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${l10n.issuer} ${credential.issuer}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                _buildCredentialInfo(
                  l10n.issuanceDate,
                  DateFormat.yMMMd().format(credential.issuanceDate),
                  Icons.calendar_today,
                ),
                if (credential.expirationDate != null)
                  _buildCredentialInfo(
                    l10n.expirationDate,
                    DateFormat.yMMMd().format(credential.expirationDate!),
                    Icons.event_busy,
                  ),
                _buildCredentialInfo(
                  l10n.credentialId,
                  credential.id,
                  Icons.tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.verificationResults),
        if (_isVerifying)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Vérification en cours...'),
                  ],
                ),
              ),
            ),
          )
        else
          _statusResult != null
              ? _buildStatusResultCard(l10n)
              : const Card(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Text('Aucune vérification effectuée'),
                    ),
                  ),
                ),
      ],
    );
  }

  Widget _buildStatusResultCard(AppLocalizations l10n) {
    final status = _statusResult!;
    final statusIcon = _getStatusIcon(status.status);
    final statusColor = _getStatusColor(status.status);
    final statusText = _getStatusText(status.status, l10n);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              statusIcon,
              size: 64,
              color: statusColor,
            ),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              status.details ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (status.error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Text(
                  status.error!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red.shade700,
                      ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Dernière vérification: ${DateFormat.yMMMd().add_Hm().format(status.checkedAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalDetails(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.technicalDetails),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.statusList2021Title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildTechnicalInfoRow(
                  l10n.protocolLabel,
                  'Status List 2021 (W3C)',
                ),
                _buildTechnicalInfoRow(
                  l10n.credentialId,
                  _statusResult!.credentialId,
                ),
                _buildTechnicalInfoRow(
                  l10n.statusTypeLabel,
                  _statusResult!.status.toString(),
                ),
                _buildTechnicalInfoRow(
                  l10n.verificationTimestampLabel,
                  _statusResult!.checkedAt.toIso8601String(),
                ),
                if (_statusResult!.details != null)
                  _buildTechnicalInfoRow(
                    l10n.detailsLabel,
                    _statusResult!.details!,
                  ),
                if (_statusResult!.error != null)
                  _buildTechnicalInfoRow(
                    l10n.errorLabel,
                    _statusResult!.error!,
                    isError: true,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusInfoCard(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.aboutStatusList2021),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.statusList2021Description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  l10n.howItWorksTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(_getHowItWorksStep(index, l10n)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    // Action pour en savoir plus
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.learnMoreNotImplementedMessage),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: Text(l10n.learnMoreButton),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialInfo(
    String label,
    String value,
    IconData icon, {
    int maxLines = 2,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  maxLines: maxLines,
                  overflow: overflow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalInfoRow(
    String label,
    String value, {
    bool isError = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: isError
                  ? TextStyle(color: Colors.red.shade700)
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCredentialTypeIcon(List<String> typeList) {
    final type = typeList.isNotEmpty ? typeList.first.toLowerCase() : '';

    if (type.contains('identity')) {
      return Icons.badge;
    } else if (type.contains('diploma') || type.contains('degree')) {
      return Icons.school;
    } else if (type.contains('certificate')) {
      return Icons.verified;
    } else if (type.contains('membership')) {
      return Icons.card_membership;
    } else if (type.contains('license') || type.contains('licence')) {
      return Icons.drive_eta;
    } else if (type.contains('health')) {
      return Icons.local_hospital;
    } else {
      return Icons.description;
    }
  }

  IconData _getStatusIcon(CredentialStatusType status) {
    switch (status) {
      case CredentialStatusType.valid:
        return Icons.check_circle;
      case CredentialStatusType.revoked:
        return Icons.block;
      case CredentialStatusType.expired:
        return Icons.timer_off;
      case CredentialStatusType.unknown:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(CredentialStatusType status) {
    switch (status) {
      case CredentialStatusType.valid:
        return Colors.green;
      case CredentialStatusType.revoked:
        return Colors.red;
      case CredentialStatusType.expired:
        return Colors.amber;
      case CredentialStatusType.unknown:
        return Colors.grey;
    }
  }

  String _getStatusText(CredentialStatusType status, AppLocalizations l10n) {
    switch (status) {
      case CredentialStatusType.valid:
        return l10n.statusValid;
      case CredentialStatusType.revoked:
        return l10n.statusRevoked;
      case CredentialStatusType.expired:
        return l10n.statusExpired;
      case CredentialStatusType.unknown:
        return l10n.statusUnknown;
    }
  }

  String _getHowItWorksStep(int index, AppLocalizations l10n) {
    switch (index) {
      case 0:
        return l10n.statusList2021Step1;
      case 1:
        return l10n.statusList2021Step2;
      case 2:
        return l10n.statusList2021Step3;
      default:
        return '';
    }
  }
}
