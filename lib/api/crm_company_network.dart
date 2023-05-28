import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<int> countCompanies() async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  final response = await http.get(
    crmUrl + "Company/Count?" + r"$filter= createdDate gt DateTime'2016-01-01'",
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $accessToken',
    },
  );

  try {
    if (response.statusCode == 200) {
      //parse the JSON.
      return jsonDecode(response.body);
    } else {
      //throw an exception.
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    print(e);
  }
}

Future<CrmCompanyApi> fetchCrmComanyById() async {
  final response =
      await http.get('http://95.174.12.121:81/api/v1/Company/Get/8');

  if (response.statusCode == 200) {
    //parse the JSON.
    return CrmCompanyApi.fromJson(jsonDecode(response.body));
  } else {
    //throw an exception.
    throw Exception('Failed to load weather data');
  }
}

Future<String> fetchCrmComanyNameById(int id) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  final response = await http.get(
    crmUrl + 'Company/Get/' + id.toString(),
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $accessToken',
    },
  );

  try {
    if (response.statusCode == 200) {
      //parse the JSON.
      return CrmCompanyApi.fromJson(jsonDecode(response.body)).companyName;
    } else {
      //throw an exception.
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    print(e);
  }
}

Future<List<CrmCompanyApi>> fetchCompaniesStartsWith(
    String companyString) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  var headers = {
    'Authorization': 'Bearer ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=qhiddkxshn5mzkgc3zgqo35j'
  };

  var request = http.Request(
      'GET',
      Uri.parse(crmUrl +
          r"Company/SearchByODataCriteria?$filter=" +
          "startswith(companyName, '$companyString')" +
          r"&$orderBy=id"));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmCompanyApi.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<CrmCompanyApi>> fetchCompanies() async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  int count = await countCompanies();
  print("---------------------------------$count-----------------------------");

  var headers = {
    'Authorization': 'Bearer ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=qhiddkxshn5mzkgc3zgqo35j'
  };

  var request = http.Request('GET',
      Uri.parse(crmUrl + r"Company/SearchByODataCriteria?$orderBy=id&top=10"));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmCompanyApi.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

class CrmCompanyApi {
  int id;
  String code;
  String companyName;
  String companyDescription;
  String address;
  String province;
  String region;
  String state;
  String zipCode;
  String webSite;
  List<Emails> emails;
  List<Phones> phones;

  CrmCompanyApi({
    this.id,
    this.code,
    this.companyName,
    this.companyDescription,
    this.address,
    this.province,
    this.region,
    this.state,
    this.zipCode,
    this.webSite,
    this.phones,
    this.emails,
  });

  CrmCompanyApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    companyName = json['companyName'];
    companyDescription = json['description'];
    address = json['address'];
    province = json['province'];
    region = json['region'];
    zipCode = json['zipCode'];
    state = json['state'];
    webSite = json['webSite'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach(
        (v) {
          phones.add(Phones.fromJson(v));
        },
      );
    }
    if (json['phones'] == null) {
      phones = [];
    }
    if (json['emails'] != null) {
      emails = <Emails>[];
      json['emails'].forEach(
        (v) {
          emails.add(Emails.fromJson(v));
        },
      );
    }
    if (json['emails'] == null) {
      emails = [];
    }
  }
}

class Phones {
  String phoneNumber;
  Phones({this.phoneNumber});

  Phones.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['value'];
  }
}

class Emails {
  String email;
  Emails({this.email});
  Emails.fromJson(Map<String, dynamic> json) {
    email = json['value'];
  }
}
