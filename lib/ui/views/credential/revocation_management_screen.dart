import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/domain/credential/revocation_service.dart';
import 'package:did_app/infrastructure/credential/status_list_2021_revocation_service.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:intl/intl.dart';

/// Écran de gestion des révocations d'attestations
class RevocationManagementScreen extends ConsumerStatefulWidget {
  final String credentialId;

  const RevocationManagementScreen({
    Key? key,
    required this.credentialId,
  }) : super(key: key);

  @override
  ConsumerState<RevocationManagementScreen> createState() =>
      _RevocationManagementScreenState();
}

class _RevocationManagementScreenState
    extends ConsumerState<RevocationManagementScreen> {
  bool _isLoading = false;
  bool _isRevoked = false;
  String? _error;
  List<RevocationHistoryEntry> _history = [];
  RevocationReason _selectedReason = RevocationReason.compromised;
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final revocationService = ref.read(revocationServiceProvider);

      // Vérifier si l'attestation est révoquée
      _isRevoked = await revocationService.isRevoked(widget.credentialId);

      // Charger l'historique de révocation
      _history =
          await revocationService.getRevocationHistory(widget.credentialId);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _revokeCredential() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final revocationService = ref.read(revocationServiceProvider);

      final result = await revocationService.revokeCredential(
        credentialId: widget.credentialId,
        reason: _selectedReason,
        details:
            _detailsController.text.isNotEmpty ? _detailsController.text : null,
      );

      if (result.success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.revocationSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }

        _detailsController.clear();
        await _loadData();
      } else {
        setState(() {
          _isLoading = false;
          _error = result.errorMessage;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _unrevokeCredential() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final revocationService = ref.read(revocationServiceProvider);

      final result = await revocationService.unrevokeCredential(
        credentialId: widget.credentialId,
        details:
            _detailsController.text.isNotEmpty ? _detailsController.text : null,
      );

      if (result.success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.unrevocationSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }

        _detailsController.clear();
        await _loadData();
      } else {
        setState(() {
          _isLoading = false;
          _error = result.errorMessage;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _syncStatus() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final revocationService = ref.read(revocationServiceProvider);
      await revocationService.syncRevocationStatus(widget.credentialId);
      await _loadData();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.revocationManagement),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _syncStatus,
            tooltip: l10n.syncRevocationStatus,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(l10n),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(l10n),
          const SizedBox(height: 24),
          if (_error != null) _buildErrorMessage(),
          const SizedBox(height: 16),
          _isRevoked
              ? _buildUnrevocationForm(l10n)
              : _buildRevocationForm(l10n),
          const SizedBox(height: 32),
          Text(
            l10n.revocationHistory,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildHistoryList(l10n),
        ],
      ),
    );
  }

  Widget _buildStatusCard(AppLocalizations l10n) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.credentialStatus,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  _isRevoked ? Icons.block : Icons.check_circle,
                  color: _isRevoked ? Colors.red : Colors.green,
                  size: 36,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _isRevoked ? l10n.credentialRevoked : l10n.credentialValid,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _isRevoked ? Colors.red : Colors.green,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.credentialId,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              widget.credentialId,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _error!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevocationForm(AppLocalizations l10n) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.revokeCredential,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<RevocationReason>(
              value: _selectedReason,
              decoration: InputDecoration(
                labelText: l10n.revocationReason,
                border: const OutlineInputBorder(),
              ),
              items: RevocationReason.values.map((reason) {
                return DropdownMenuItem<RevocationReason>(
                  value: reason,
                  child: Text(_getReasonText(reason, l10n)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedReason = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: l10n.revocationDetails,
                border: const OutlineInputBorder(),
                hintText: l10n.revocationDetailsHint,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _revokeCredential,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(l10n.revokeCredential),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.revocationWarning,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnrevocationForm(AppLocalizations l10n) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.unrevokeCredential,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: l10n.unrevocationReason,
                border: const OutlineInputBorder(),
                hintText: l10n.unrevocationReasonHint,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _unrevokeCredential,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(l10n.unrevokeCredential),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(AppLocalizations l10n) {
    if (_history.isEmpty) {
      return Center(
        child: Text(
          l10n.noRevocationHistory,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final entry = _history[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              entry.action == RevocationAction.revoke
                  ? Icons.block
                  : Icons.restore,
              color: entry.action == RevocationAction.revoke
                  ? Colors.red
                  : Colors.blue,
            ),
            title: Text(
              entry.action == RevocationAction.revoke
                  ? l10n.credentialRevoked
                  : l10n.credentialUnrevoked,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().add_Hm().format(entry.timestamp)),
                if (entry.reason != null)
                  Text(
                      '${l10n.reason}: ${_getReasonText(entry.reason!, l10n)}'),
                if (entry.details != null && entry.details!.isNotEmpty)
                  Text('${l10n.details}: ${entry.details}'),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  String _getReasonText(RevocationReason reason, AppLocalizations l10n) {
    switch (reason) {
      case RevocationReason.compromised:
        return l10n.revocationReasonCompromised;
      case RevocationReason.superseded:
        return l10n.revocationReasonSuperseded;
      case RevocationReason.noLongerValid:
        return l10n.revocationReasonNoLongerValid;
      case RevocationReason.issuerRevoked:
        return l10n.revocationReasonIssuerRevoked;
      case RevocationReason.other:
        return l10n.revocationReasonOther;
    }
  }
}
