import 'package:crm_mobile/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CrmAlertDialog extends StatelessWidget {
  final String companyName;
  final String alertMessage;

  CrmAlertDialog({this.companyName, this.alertMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        companyName,
        style: const TextStyle(color: Colors.blueAccent),
      ),
      content: Text(
        alertMessage,
        style: const TextStyle(color: Colors.blueAccent),
      ),
      backgroundColor: Colors.white,
    );
  }
}
