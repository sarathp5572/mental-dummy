

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/token_expiry/show_error_popup.dart';
import 'package:mentalhelth/screens/token_expiry/token_expiry.dart';

class ErrorPopupWidget extends StatefulWidget {
  final String errorMessage;
  final VoidCallback onLogin;

  const ErrorPopupWidget({
    required this.errorMessage,
    required this.onLogin,
    Key? key,
  }) : super(key: key);

  @override
  _ErrorPopupWidgetState createState() => _ErrorPopupWidgetState();
}

class _ErrorPopupWidgetState extends State<ErrorPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _showErrorPopup(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SizedBox(); // Return an empty widget
        }
      },
    );
  }

  Future<void> _showErrorPopup() async {
    setState(() {
      TokenManager.setError(true); // Set error state globally
    });
    showErrorPopupDialog(context, widget.errorMessage, widget.onLogin);
    // After closing the dialog, reset error state
    setState(() {
      TokenManager.setError(false);
    });
  }
}
