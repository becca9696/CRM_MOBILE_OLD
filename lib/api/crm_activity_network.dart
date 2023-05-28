import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//Aggiorna lo stato dell'attività - 0:Da Fare 1: Fatta, 2:Annullata
Future<void> updateToDoActivities(int activityId, int toDo) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");
  dynamic ownerId = await SessionManager().get("userId");

  http
      .post(
    crmUrl + 'Activity/CreateOrUpdate/',
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, String>{
      'id': activityId.toString(),
      'toDo': toDo.toString(),
      'lastModifiedById': ownerId.toString(),
    }),
    encoding: Encoding.getByName("utf-8"),
  )
      .then((response) {
    try {
      if (response.statusCode == 200) {
        print(json.decode(response.body));
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  });
}

//Ritorna la lista delle attività del giorno corrente
/*Future<List<CrmActivity>> fetchDayActivities(String today) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");
  dynamic ownerId = await SessionManager().get("userId");

  var headers = {
    'Authorization': 'Bearer' + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=bkgy1bcllooihn3w2zc22zt1'
  };

  var request = http.Request(
    'GET',
    /*Uri.parse(crmUrl +
        r"Activity/SearchByODataCriteria?$filter=" +
        "activityDate ge " +
        today +
        "T00:00:00Z and activityDate le " +
        today +
        "T23:59:59Z and (ownerId eq " +
        ownerId.toString() +
        " or idCompanion eq " +
        ownerId.toString() +
        ") and subTypeId eq 12" +
        r"&$orderBy=activityDate"),*/
    Uri.parse(
      crmUrl +
          r"Activity/SearchByODataCriteria?$filter=" +
          "activityDate ge " +
          today +
          "T00:00:00Z and activityDate le " +
          today +
          "T23:59:59Z and (ownerId eq " +
          ownerId.toString() +
          " or idCompanion eq " +
          ownerId.toString() +
          ")",
    ),
  );

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmActivity.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}*/

Future<List<CrmActivity>> fetchDayActivities(String today) async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");
  dynamic ownerId = await SessionManager().get("userId");

  var headers = {
    'Authorization': 'Bearer' + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=bkgy1bcllooihn3w2zc22zt1'
  };

  var request = http.Request(
    'GET',
    Uri.parse(
      crmUrl +
          r"Activity/SearchByODataCriteria?$filter=" +
          "activityDate ge " +
          today +
          "T00:00:00Z and activityDate le " +
          today +
          "T23:59:59Z and (ownerId eq " +
          ownerId.toString() +
          " or idCompanion eq " +
          ownerId.toString() +
          ")",
    ),
  );

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmActivity.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//Ritorna la lista di tutte le attività
Future<List<CrmActivity>> fetchActivities() async {
  GlobalConfiguration cfg = GlobalConfiguration();
  final String crmUrl = cfg.get("URL");
  dynamic accessToken = await SessionManager().get("accessToken");
  dynamic ownerId = await SessionManager().get("userId");

  var headers = {
    'Authorization': 'Bearer' + ' ' + accessToken,
    'Cookie': 'ASP.NET_SessionId=bkgy1bcllooihn3w2zc22zt1'
  };
  var request = http.Request(
      'GET',
      Uri.parse(crmUrl +
          r'Activity/Search?$filter=ownerId%20eq%20' +
          ownerId.toString()));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      print(response.body);
      print("\n\n\n\n----------token=$accessToken----------\n\n\n");
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => CrmActivity.fromJson(data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

class CrmActivity {
  final int id;
  final int ownerId;
  final int idCompanion;
  final int companyId;
  final String activityDate;
  final String activityEndDate;
  final int jobOrderId;
  final int jobOrderTaskId;
  final int opportunityId;
  final String subject;
  final int type;
  final int subTypeId;
  final int toDo;
  final String description;
  final String description2;

  CrmActivity({
    this.id,
    this.companyId,
    this.ownerId,
    this.idCompanion,
    this.activityDate,
    this.activityEndDate,
    this.jobOrderId,
    this.jobOrderTaskId,
    this.opportunityId,
    this.subject,
    this.type,
    this.subTypeId,
    this.toDo,
    this.description,
    this.description2,
  });

  factory CrmActivity.fromJson(Map<String, dynamic> json) {
    return CrmActivity(
      id: json['id'] as int,
      companyId: json['companyId'] as int,
      ownerId: json['ownerId'] as int,
      idCompanion: json['idCompanion'] as int,
      activityDate: json['activityDate'].toString(),
      activityEndDate: json['activityEndDate'].toString(),
      jobOrderId: json['jobOrderId'] as int,
      jobOrderTaskId: json['jobOrderTaskId'] as int,
      opportunityId: json['opportunityId'] as int,
      subject: json['subject'].toString(),
      type: json['type'] as int,
      subTypeId: json['subTypeId'] as int,
      toDo: json['toDo'] as int,
      description: json['description'].toString(),
      description2: json['description2'].toString(),
    );
  }
}
