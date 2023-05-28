import 'package:flutter/material.dart';

class ActivityTileTitle extends StatelessWidget {
  DateTime sDt;
  DateTime eDt;
  int type;

  ActivityTileTitle({
    this.sDt,
    this.eDt,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          ("${sDt.hour.toString().padLeft(2, '0')}:${sDt.minute.toString().padLeft(2, "0")}"),
        ),
        type == 6
            ? Text(
                (" - ${eDt.hour.toString().padLeft(2, '0')}:${eDt.minute.toString().padLeft(2, "0")}"),
              )
            : const Text(""),
      ],
    );
  }
}
