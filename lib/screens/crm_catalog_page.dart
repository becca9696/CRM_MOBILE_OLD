import 'package:crm_mobile/api/crm_catalog_category_network.dart';
import 'package:crm_mobile/api/crm_catalog_network.dart';
import 'package:crm_mobile/crm_components/crm_catalog_tile.dart';
import 'package:crm_mobile/crm_components/crm_category_tile.dart';
import 'package:crm_mobile/crm_components/crm_no_catalog.dart';
import 'package:crm_mobile/crm_components/crm_no_category.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/screens/crm_catalog_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrmCatalogPage extends StatefulWidget {
  const CrmCatalogPage({Key key}) : super(key: key);

  @override
  _CrmCatalogPageState createState() => _CrmCatalogPageState();
}

class _CrmCatalogPageState extends State<CrmCatalogPage> {
  Future<List<CrmCatalogCategory>> _futureCategories;
  Future<List<CrmCatalog>> _futureCatalog;

  final _textSearchController = TextEditingController();

  @override
  void initState() {
    _futureCategories = fetchCategories();
    _futureCatalog = fetchCatalog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tCatalogTitle),
      ),
      body: Column(
        children: [
          // --- Categorie ---
          /*FutureBuilder<List<CrmCatalogCategory>>(
            future: _futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<CrmCatalogCategory> categories = snapshot.data;
                  if (categories.isNotEmpty) {
                    return SizedBox(
                      height: tCategoryCardHeight,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(tCategoryCardEdges),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryListTile(
                            catalogId: categories[index].id,
                            catalogDescription: categories[index].description,
                            onPress: () {},
                          );
                        },
                      ),
                    );
                  } else {
                    return const CrmNoCategoryText();
                  }
                } else {
                  return Text("${snapshot.error}");
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              // By default show a loading spinner.
            },
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              controller: _textSearchController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search_outlined),
                labelText: "Cerca",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          FutureBuilder<List<CrmCatalog>>(
            future: _futureCatalog,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<CrmCatalog> catalog = snapshot.data;
                  if (catalog.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        itemCount: catalog.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CatalogListTile(
                            code: catalog[index].code,
                            productName: catalog[index].productName,
                            id: catalog[index].id,
                            unit: catalog[index].unit,
                            price: catalog[index].price,
                            vat: catalog[index].vat,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CrmCatalogDetailsPage(
                                    code: catalog[index].code,
                                    description: catalog[index].description,
                                    categoryName: catalog[index].categoryName,
                                    id: catalog[index].id,
                                    productName: catalog[index].productName,
                                    unit: catalog[index].unit,
                                    price: catalog[index].price,
                                    vat: catalog[index].vat,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const CrmNoCatalogText();
                  }
                } else {
                  return Text("${snapshot.error}");
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              // By default show a loading spinner.
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _futureCatalog =
                fetchCatalogStartsWith(_textSearchController.text.trim());
          });
        },
        child: const Icon(Icons.search_outlined),
        heroTag: "catalogSearch",
      ),
    );
  }
}
