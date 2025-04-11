import 'package:flutter/material.dart';

/// Represents a section in the info dialog.
class InfoSectionData {

  InfoSectionData({
    required this.text,
    required this.icon,
    this.iconColor = Colors.blue, // Default color
  });
  final String text;
  final IconData icon;
  final Color iconColor;
}

/// Utility class for displaying common dialogs.
class DialogUtils {
  /// Shows a standard loading dialog.
  static Future<void> showLoadingDialog(
    BuildContext context,
    String message,
  ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must not dismiss it manually
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  /// Hides the current dialog.
  static void hideDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pop(); // Use rootNavigator to pop dialogs
  }

  /// Shows a standard error dialog.
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    String closeText = 'Close', // Default close text
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.red)),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a standard confirmation dialog.
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Confirm', // Default confirm text
    String cancelText = 'Cancel', // Default cancel text
    bool destructiveAction = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false when cancelled
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructiveAction
                    ? Colors.red
                    : null, // Highlight destructive actions
              ),
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true when confirmed
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a standard result dialog (success or failure).
  static Future<void> showResultDialog({
    required BuildContext context,
    required String title,
    required String content,
    required bool isSuccess,
    String closeText = 'Close', // Default close text
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(content, textAlign: TextAlign.center),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a standard information dialog with sections.
  static Future<void> showInfoDialog({
    required BuildContext context,
    required String title,
    required List<InfoSectionData> sections,
    String closeText = 'Close', // Default close text
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              // Use ListBody for proper spacing
              children: sections
                  .map((section) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(section.icon,
                                color: section.iconColor, size: 20,),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(section.text),
                            ),
                          ],
                        ),
                      ),)
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Add other dialog methods here later (confirmation, error, info, etc.)
}
