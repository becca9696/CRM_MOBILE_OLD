import 'package:crm_mobile/constants/image_strings.dart';
import 'package:crm_mobile/crm_components/crm_product_image.dart';
import 'package:flutter/material.dart';

class CatalogListTile extends StatelessWidget {
  //final bool active;
  //final int category;
  //final String categoryName;
  final int id;
  //final String description;
  final String productName;
  final String unit;
  final double price;
  final double vat;
  final String code;
  final Function onPress;

  CatalogListTile({
    //this.active,
    //this.category,
    //this.categoryName,
    this.id,
    //this.description,
    this.productName,
    this.unit,
    this.price,
    this.vat,
    this.code,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ExpansionTile(
        title: Text("Codice: $code"),
        subtitle: Text("UM: $unit IVA: $vat Prezzo: $price"),
        leading: CrmProductImage(
          image: code,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              productName,
            ),
          ),
        ],
      ),
    );
  }
}
