import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CrmWorkActivityDetails extends StatefulWidget {
  String companyName;
  final int activityId;
  final String subject;
  final int companyId;
  final String activityDate;
  final String activityEndDate;
  final int type;
  final int subTypeId;
  int toDo;
  final int idCompanion;
  final String description;
  final String description2;

  CrmWorkActivityDetails({
    this.companyName,
    this.activityId,
    this.subject,
    this.companyId,
    this.activityDate,
    this.activityEndDate,
    this.type,
    this.subTypeId,
    this.toDo,
    this.idCompanion,
    this.description,
    this.description2,
  });

  @override
  _CrmWorkActivityDetailsState createState() => _CrmWorkActivityDetailsState();
}

class _CrmWorkActivityDetailsState extends State<CrmWorkActivityDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tActivityTitle),
        backgroundColor: _getActivityTypeColor(widget.type),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tPaddingAll),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(tPaddingAll / 4),
          children: [
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.subject),
                labelText: "Oggetto",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.subject,
            ),
            const SizedBox(height: tSizedBoxHeight),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alarm_outlined),
                      labelText: "Dalle",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.activityDate,
                  ),
                ),
                const SizedBox(width: tSizedBoxWidth),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alarm_outlined),
                      labelText: "Alle",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.activityEndDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city_outlined),
                labelText: "Cliente",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.companyName,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                labelText: "Descrizione",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.description,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                labelText: "Nata Interna",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.description2,
            ),
          ],
        ),
      ),
    );
  }
}

Color _getActivityTypeColor(int type) {
  if (type == 1) {
    return Colors.yellow[600];
  }
  if (type == 2) {
    return Colors.brown[400];
  }
  if (type == 3) {
    return Colors.grey[400];
  }
  if (type == 4) {
    return Colors.purple[400];
  }
  if (type == 5) {
    return Colors.blue[400];
  }
  if (type == 6) {
    return Colors.pink[400];
  }
  if (type == 7) {
    return Colors.green[400];
  } else {
    return Colors.orange[400];
  }
}
