import 'package:crm_mobile/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CrmNoCategoryText extends StatelessWidget {
  const CrmNoCategoryText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        tNoCategory,
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
