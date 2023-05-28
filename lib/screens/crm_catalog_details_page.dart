import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/crm_components/crm_product_image.dart';
import 'package:flutter/material.dart';

class CrmCatalogDetailsPage extends StatefulWidget {
  final String categoryName;
  final int id;
  final String description;
  final String productName;
  final String unit;
  final double price;
  final double vat;
  final String code;
  final Function onPress;

  CrmCatalogDetailsPage({
    this.categoryName,
    this.id,
    this.description,
    this.productName,
    this.unit,
    this.price,
    this.vat,
    this.code,
    this.onPress,
  });

  @override
  _CrmCatalogDetailsPageState createState() => _CrmCatalogDetailsPageState();
}

class _CrmCatalogDetailsPageState extends State<CrmCatalogDetailsPage> {
  int qta = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Codice: ${widget.code}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tPaddingAll),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(tPaddingAll / 4),
          children: [
            Center(
              child: CrmProductImage(image: widget.code),
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.categoryName,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: "Codice",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.code,
            ),
            const SizedBox(height: tSizedBoxHeight),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_size_outlined),
                      labelText: "Um",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.unit,
                  ),
                ),
                const SizedBox(width: tSizedBoxWidth),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.euro_outlined),
                      labelText: "Prezzo",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.price.toString(),
                  ),
                ),
                const SizedBox(width: tSizedBoxWidth),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.perm_data_setting_outlined),
                      labelText: "IVA",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.vat.toString(),
                  ),
                ),
              ],
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
              initialValue: widget.productName,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                labelText: "Descrizione Estesa",
                border: OutlineInputBorder(),
              ),
              initialValue: widget.description,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: tPaddingSymmetricHorizontal,
          vertical: tPaddingSymmetricVertical,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  qta--;
                });
              },
              child: const Icon(Icons.remove_outlined),
              heroTag: "minus",
            ),
            const SizedBox(height: tSizedBoxHeight),
            Text(qta.toString()),
            const SizedBox(
              height: tSizedBoxHeight,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  qta++;
                });
              },
              child: const Icon(Icons.add_outlined),
              heroTag: "plus",
            ),
          ],
        ),
      ),
    );
  }
}
