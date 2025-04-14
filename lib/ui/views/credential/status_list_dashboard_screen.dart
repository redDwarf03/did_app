import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:did_app/infrastructure/credential/status_list_2021_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Screen for managing Status List 2021 status lists
class StatusListDashboardScreen extends ConsumerStatefulWidget {
  const StatusListDashboardScreen({super.key});

  @override
  ConsumerState<StatusListDashboardScreen> createState() =>
      _StatusListDashboardScreenState();
}

class _StatusListDashboardScreenState
    extends ConsumerState<StatusListDashboardScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  final List<String> _statusListUrls = [];
  StatusList2021Credential? _selectedList;

  @override
  void initState() {
    super.initState();
    _loadSavedStatusLists();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  /// Load saved status lists
  Future<void> _loadSavedStatusLists() async {
    // In a real implementation, load from a persistent data source
    setState(() {
      _statusListUrls.addAll([
        'https://example.com/status/list1',
        'https://example.com/status/list2',
      ]);
    });
  }

  /// Add a new status list
  Future<void> _addStatusList() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _error = 'Please enter a valid URL';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final statusListService = ref.read(statusList2021ServiceProvider);
      await statusListService.refreshStatusList(url);

      setState(() {
        if (!_statusListUrls.contains(url)) {
          _statusListUrls.add(url);
        }
        _urlController.clear();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Load the details of a status list
  Future<void> _loadStatusListDetails(String url) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _selectedList = null;
    });

    try {
      final statusListService = ref.read(statusList2021ServiceProvider);
      final statusList = await statusListService.getStatusList(url);
      setState(() {
        _selectedList = statusList;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Remove a status list
  void _removeStatusList(String url) {
    setState(() {
      _statusListUrls.remove(url);
      if (_selectedList?.id == url) {
        _selectedList = null;
      }
    });
  }

  void _showHelp(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.statusListHowItWorks),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.statusListDescription),
              const SizedBox(height: 16),
              Text(l10n.statusListHowItWorksContent),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statusListDashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelp(context, l10n),
            tooltip: l10n.helpTooltip,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAddStatusListForm(l10n),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildStatusListUrlList(l10n),
                ),
                Expanded(
                  flex: 3,
                  child: _selectedList != null
                      ? _buildStatusListDetails(l10n)
                      : Center(
                          child: Text(l10n.statusListNoCache),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddStatusListForm(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: l10n.statusListUrlLabel,
                border: const OutlineInputBorder(),
              ),
              enabled: !_isLoading,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _addStatusList,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.statusListVerifyButton),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusListUrlList(AppLocalizations l10n) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.managedStatusListsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(),
          Expanded(
            child: _statusListUrls.isEmpty
                ? Center(
                    child: Text(l10n.statusListNoCache),
                  )
                : ListView.builder(
                    itemCount: _statusListUrls.length,
                    itemBuilder: (context, index) {
                      final url = _statusListUrls[index];
                      return ListTile(
                        title: Text(
                          url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(l10n.tapToViewDetails),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: l10n.removeStatusListTooltip,
                          onPressed: () => _removeStatusList(url),
                        ),
                        onTap: () => _loadStatusListDetails(url),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusListDetails(AppLocalizations l10n) {
    if (_selectedList == null) return const SizedBox();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.statusListDetailsTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: l10n.refreshStatusListTooltip,
                  onPressed: () => _loadStatusListDetails(_selectedList!.id),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDetailRow(
                  l10n.listIdLabel,
                  _selectedList!.id,
                ),
                _buildDetailRow(
                  l10n.issuerLabel,
                  _selectedList!.issuer,
                ),
                _buildDetailRow(
                  l10n.issuanceDateLabel,
                  DateFormat.yMMMd().format(_selectedList!.issuanceDate),
                ),
                _buildDetailRow(
                  l10n.expirationDateLabel,
                  _selectedList!.expirationDate != null
                      ? DateFormat.yMMMd()
                          .format(_selectedList!.expirationDate!)
                      : l10n.neverExpires,
                ),
                _buildDetailRow(
                  l10n.statusPurposeLabel,
                  _selectedList!.credentialSubject.statusPurpose.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
