import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'crm_me_network.dart';

Future<void> saveAuthData(
  String accessToken,
  int expiresIn,
  int result,
  String tokenType,
  int userId,
  String userName,
  String avatar,
  bool isAdmin,
  bool isAgent,
  String email,
) async {
  var session = SessionManager();
  await session.set("accessToken", accessToken);
  await session.set("expiresIn", expiresIn);
  await session.set("result", result);
  await session.set("tokenType", tokenType);
  await session.set("userId", userId);

  CrmMe crmMeData = CrmMe(
    name: userName,
    userId: userId,
    avatar: avatar,
    isAgent: isAgent,
    isAdmin: isAdmin,
    email: email,
  );
  await SessionManager().set('crmMeData', crmMeData);
}

Future<bool> crmLogin(String username, String password) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");

  CrmMe crmMe;

  var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'ASP.NET_SessionId=yhpnjixtllk4gymudwfw5uce'
  };
  var request = http.Request('POST', Uri.parse(crmUrl + 'Auth/Login'));
  request.body = json.encode({
    "Grant_type": "password",
    "Password": password,
    "Username": username,
  });
  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      print('response.body ' + response.body);

      CrmAuthApi crmAuthData;
      crmAuthData = CrmAuthApi.fromJson(jsonDecode(response.body));

      crmMe =
          await fetchCrmMeData(crmAuthData.accessToken, crmAuthData.tokenType);

      saveAuthData(
        crmAuthData.accessToken,
        crmAuthData.expiresIn,
        crmAuthData.result,
        crmAuthData.tokenType,
        crmMe.userId,
        crmMe.name,
        crmMe.avatar,
        crmMe.isAdmin,
        crmMe.isAgent,
        crmMe.email,
      );

      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  } catch (e) {
    print(e);
  }
}

class CrmAuthApi {
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final int result;
  final String tokenType;

  CrmAuthApi({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.result,
    this.tokenType,
  });

  factory CrmAuthApi.fromJson(Map<String, dynamic> json) {
    return CrmAuthApi(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'] as int,
      refreshToken: json['refresh_token'],
      result: json['result'] as int,
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataAuth = Map<String, dynamic>();
    dataAuth['accessToken'] = accessToken;
    dataAuth["expiresIn"] = this.expiresIn;
    dataAuth["refreshToken"] = this.refreshToken;
    dataAuth["result"] = this.result;
    dataAuth["tokenType"] = this.tokenType;
    return dataAuth;
  }
}
