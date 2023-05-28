import 'package:flutter/material.dart';

class ActivityCicrleAvatar extends StatelessWidget {
  final int type;

  ActivityCicrleAvatar({this.type});

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return CircleAvatar(
        child: const Icon(
          Icons.call_end_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.yellow[600],
      );
    }
    if (type == 2) {
      return CircleAvatar(
        child: const Icon(
          Icons.email_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.brown[400],
      );
    }
    if (type == 3) {
      return CircleAvatar(
        child: const Icon(
          Icons.print_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[400],
      );
    }
    if (type == 4) {
      return CircleAvatar(
        child: const Icon(
          Icons.post_add_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.purple[400],
      );
    }
    if (type == 5) {
      return CircleAvatar(
        child: const Icon(
          Icons.alternate_email,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blue[400],
      );
    }
    if (type == 6) {
      return CircleAvatar(
        child: const Icon(
          Icons.euro_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.pink[400],
      );
    }
    if (type == 7) {
      return CircleAvatar(
        child: const Icon(
          Icons.lightbulb_outline,
          color: Colors.white70,
        ),
        backgroundColor: Colors.green[400],
      );
    } else {
      return CircleAvatar(
        child: const Icon(
          Icons.account_tree_outlined,
          color: Colors.white70,
        ),
        backgroundColor: Colors.orange[400],
      );
    }
  }
}
