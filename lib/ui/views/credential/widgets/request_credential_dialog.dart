import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Dialog widget to request a specific type of credential.
class RequestCredentialDialog extends StatelessWidget {

  const RequestCredentialDialog({required this.onRequestSelected, super.key});
  final Function(String type) onRequestSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return AlertDialog(
      title: Text(l10n.requestCredentialDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRequestOption(
              context,
              icon: Icons.assignment_ind,
              iconColor: Colors.blue,
              title: l10n.credentialIdentityType,
              subtitle: l10n.credentialIdentityIssuer,
              type: 'identity',
            ),
            const Divider(),
            _buildRequestOption(
              context,
              icon: Icons.school,
              iconColor: Colors.green,
              title: l10n.credentialDiplomaType,
              subtitle: l10n.credentialDiplomaIssuer,
              type: 'diploma',
            ),
            const Divider(),
            _buildRequestOption(
              context,
              icon: Icons.directions_car,
              iconColor: Colors.amber,
              title: l10n.credentialDrivingLicenseType,
              subtitle: l10n.credentialDrivingLicenseIssuer,
              type: 'drivingLicense',
            ),
            const Divider(),
            _buildRequestOption(
              context,
              icon: Icons.badge,
              iconColor: Colors.purple,
              title: l10n.credentialOtherType,
              subtitle: l10n.credentialOtherIssuer,
              type: 'other',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelButton),
        ),
      ],
    );
  }

  Widget _buildRequestOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String type,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.of(context).pop(); // Close the dialog first
        onRequestSelected(type); // Call the callback
      },
    );
  }
}
