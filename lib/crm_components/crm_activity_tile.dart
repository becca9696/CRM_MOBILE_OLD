import 'package:crm_mobile/api/crm_company_network.dart';
import 'package:crm_mobile/crm_components/crm_activity_tile_avatar.dart';
import 'package:crm_mobile/crm_components/crm_activity_tile_trailing.dart';
import 'package:crm_mobile/screens/crm_work_activity_page_details.dart';
import 'package:flutter/material.dart';

import 'crm_activity_tile_title.dart';

class ActivityListTile extends StatefulWidget {
  final int activityId;
  final String subject;
  final int companyId;
  final String activityDate;
  final String activityEndDate;
  final int type;
  final int subTypeId;
  int toDo;
  final int idCompanion;
  final Function updateTodo;
  final String description;
  final String description2;

  ActivityListTile({
    this.activityId,
    this.subject,
    this.companyId,
    this.activityDate,
    this.activityEndDate,
    this.type,
    this.subTypeId,
    this.toDo,
    this.updateTodo,
    this.idCompanion,
    this.description,
    this.description2,
  });

  @override
  _ActivityListTileState createState() => _ActivityListTileState();
}

class _ActivityListTileState extends State<ActivityListTile> {
  bool isLoading = false;
  bool isDone;
  Future<String> _futureCompanyName;
  Future<String> _companionName;

  String companyName;

  @override
  void initState() {
    _futureCompanyName = fetchCrmComanyNameById(widget.companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime activityDateFormatted =
        DateTime.parse(widget.activityDate).toLocal();
    DateTime activityEndDateFormatted =
        DateTime.parse(widget.activityEndDate).toLocal();

    return GestureDetector(
      child: ExpansionTile(
        title: ActivityTileTitle(
          sDt: activityDateFormatted,
          eDt: activityEndDateFormatted,
          type: widget.type,
        ),
        subtitle: FutureBuilder<String>(
          future: _futureCompanyName,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                companyName = snapshot.data;
                return Text(snapshot.data);
              } else {
                return const Text("");
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        leading: _getActivityTypeIcon(widget.type),
        trailing:
            ActivityTrailing(toDo: widget.toDo, activityId: widget.activityId),
        children: <Widget>[
          Text(
            widget.subject,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CrmWorkActivityDetails(
              companyName: companyName,
              activityId: widget.activityId,
              subject: widget.subject,
              companyId: widget.companyId,
              activityDate: DateTime.parse(widget.activityDate)
                  .toLocal()
                  .hour
                  .toString()
                  .padLeft(2, '0'),
              activityEndDate: DateTime.parse(widget.activityEndDate)
                  .toLocal()
                  .minute
                  .toString()
                  .padLeft(2, '0'),
              type: widget.type,
              subTypeId: widget.subTypeId,
              toDo: widget.toDo,
              idCompanion: widget.idCompanion,
              description: widget.description.isEmpty ? "" : widget.description,
              description2:
                  widget.description2.isEmpty ? "" : widget.description2,
            ),
          ),
        );
      },
    );
  }
}

ActivityCicrleAvatar _getActivityTypeIcon(int type) {
  return ActivityCicrleAvatar(
    type: type,
  );
}
