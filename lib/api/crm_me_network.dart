import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<CrmMe> fetchCrmMeData(String accessToken, String typeToken) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");

  var headers = {
    'Authorization': typeToken + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=qsjwzkstijvxgxqunadpgzir'
  };
  var request = http.Request('GET', Uri.parse(crmUrl + 'Auth/Me'));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      return CrmMe.fromJson(jsonDecode(response.body));
    } else {
      print(response.reasonPhrase);
      return null;
    }
  } catch (e) {
    print(e);
  }
}

Future<String> fetchCrmCompanionNameById(int id) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");

  var headers = {
    'Authorization': 'Bearer ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=qsjwzkstijvxgxqunadpgzir'
  };
  //var request = http.Request(
  //    'GET', Uri.parse('http://95.174.12.121:81/api/v1/Auth/Me?id=2'));
  var request = http.Request('GET', Uri.parse(crmUrl + r'Auth/Me?id=2'));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      return CrmMe.fromJson(jsonDecode(response.body)).name;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  } catch (e) {
    print(e);
  }
}

class CrmMe {
  final int userId;
  final int companyId;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final int userGroupId;
  final String name;
  final String avatar;

  CrmMe({
    this.userId,
    this.companyId,
    this.email,
    this.isAdmin,
    this.isAgent,
    this.userGroupId,
    this.name,
    this.avatar,
  });

  factory CrmMe.fromJson(Map<String, dynamic> json) {
    return CrmMe(
      userId: json['userId'] as int,
      companyId: json['companyId'] as int,
      email: json['email'],
      isAdmin: json['isAdmin'] as bool,
      isAgent: json['isAgent'] as bool,
      userGroupId: json['token_type'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    //final Map<String, dynamic> dataMe = Map<String, dynamic>();
    final Map<String, dynamic> dataMe = <String, dynamic>{};
    dataMe['userId'] = userId;
    dataMe["companyId"] = companyId;
    dataMe["email"] = email;
    dataMe["isAdmin"] = isAdmin;
    dataMe["isAgent"] = isAgent;
    dataMe["token_type"] = userGroupId;
    dataMe["name"] = name;
    dataMe["avatar"] = avatar;
    return dataMe;
  }
}
