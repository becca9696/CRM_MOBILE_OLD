import 'package:crm_mobile/api/crm_activity_network.dart';
import 'package:flutter/material.dart';

class ActivityTrailing extends StatefulWidget {
  int toDo;
  int activityId;

  ActivityTrailing({
    this.toDo,
    this.activityId,
  });

  @override
  _ActivityTrailingState createState() => _ActivityTrailingState();
}

class _ActivityTrailingState extends State<ActivityTrailing> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.toDo == 1 ? true : false,
      onChanged: (bool isChecked) async {
        setState(() {
          if (widget.toDo == 1) {
            widget.toDo = 0;
          } else {
            widget.toDo = 1;
          }
        });
        await updateToDoActivities(widget.activityId, widget.toDo)
            .then((value) => null);
      },
    );
  }
}
