import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//Ritorna la lista delle categorie del catalogo
Future<List<CrmCatalog>> fetchCatalog() async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  var headers = {
    'Authorization': 'Bearer' + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=bkgy1bcllooihn3w2zc22zt1'
  };

  var request = http.Request(
    'GET',
    Uri.parse(crmUrl +
        r"Catalog/SearchByODataCriteria?$filter=active eq true &$orderby=code&top=10"),
  );

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmCatalog.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<CrmCatalog>> fetchCatalogStartsWith(String catalogCode) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  var headers = {
    'Authorization': 'Bearer' + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=bkgy1bcllooihn3w2zc22zt1'
  };

  var request = http.Request(
    'GET',
    Uri.parse(crmUrl +
        r"Catalog/SearchByODataCriteria?$filter=startswith(code,'" +
        catalogCode +
        r"') and active eq true&$orderby=code"),
  );

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmCatalog.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

class CrmCatalog {
  //In caso elimina il final

  bool active;
  int category;
  String code;
  String categoryName;
  int id;
  String description;
  String productName;
  String unit;
  double price;
  double vat;

  CrmCatalog({
    this.active,
    this.category,
    this.code,
    this.categoryName,
    this.id,
    this.description,
    this.productName,
    this.unit,
    this.price,
    this.vat,
  });

  factory CrmCatalog.fromJson(Map<String, dynamic> json) {
    return CrmCatalog(
      active: json['active'] as bool,
      category: json['category'] as int,
      categoryName: json['categoryName'].toString(),
      id: json['id'] as int,
      description: json['description'].toString(),
      productName: json['productName'].toString(),
      unit: json['unit'].toString(),
      price: json['price'] as double,
      vat: json['vat'] as double,
      code: json['code'].toString(),
    );
  }
}
