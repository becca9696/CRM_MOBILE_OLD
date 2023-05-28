import 'package:flutter/material.dart';

class CompanyAvatar extends StatelessWidget {
  final String companyName;
  final double size;

  CompanyAvatar({this.companyName, this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        companyName.substring(0, 2).toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
      maxRadius: size,
    );
  }
}
