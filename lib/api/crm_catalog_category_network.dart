import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//Ritorna la lista delle categorie del catalogo
Future<List<CrmCatalogCategory>> fetchCategories() async {
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
        r"CatalogCategories/SearchByODataCriteria?orderBy=description"),
  );

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => CrmCatalogCategory.fromJson(data))
          .toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

class CrmCatalogCategory {
  final int id;
  final String description;

  CrmCatalogCategory({
    this.id,
    this.description,
  });

  factory CrmCatalogCategory.fromJson(Map<String, dynamic> json) {
    return CrmCatalogCategory(
      id: json['id'] as int,
      description: json['description'].toString(),
    );
  }
}
