import 'package:crm_mobile/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CrmNoCatalogText extends StatelessWidget {
  const CrmNoCatalogText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        tNoCatalog,
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
