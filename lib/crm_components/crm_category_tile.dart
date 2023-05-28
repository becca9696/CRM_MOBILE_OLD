import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  final int catalogId;
  final String catalogDescription;
  final Function onPress;

  CategoryListTile({
    this.catalogId,
    this.catalogDescription,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(child: Text(catalogDescription)),
      ),
    );
  }
}
