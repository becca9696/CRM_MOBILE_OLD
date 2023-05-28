import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<CrmCompanyContacs>> fetchCompanyContactsById(int id) async {
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
          r"Company/CompanyContacts/" +
          id.toString() +
          r"?$orderBy=id"));

  request.headers.addAll(headers);

  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => CrmCompanyContacs.fromJson(data))
          .toList();
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    return [];
  }
}

class CrmCompanyContacs {
  int companyId;
  int id;
  String name;
  String surname;
  int ownerId;
  String title;
  List<ContactsPhones> phones;
  List<ContactsEmails> emails;

  CrmCompanyContacs({
    this.id,
    this.name,
    this.surname,
    this.ownerId,
    this.title,
    this.companyId,
    this.phones,
    this.emails,
  });

  CrmCompanyContacs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    name = json['name'];
    surname = json['surname'];
    ownerId = json['ownerId'];
    title = json['title'];
    if (json['phones'] != null) {
      phones = List<ContactsPhones>();
      json['phones'].forEach(
        (v) {
          phones.add(ContactsPhones.fromJson(v));
        },
      );
    }
    if (json['phones'] == null) {
      phones = [];
    }
    if (json['emails'] != null) {
      emails = List<ContactsEmails>();
      json['emails'].forEach(
        (v) {
          emails.add(ContactsEmails.fromJson(v));
        },
      );
    }
    if (json['emails'] == null) {
      emails = [];
    }
  }
}

class ContactsPhones {
  String phoneNumber;
  ContactsPhones({this.phoneNumber});

  ContactsPhones.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['value'];
  }
}

class ContactsEmails {
  String email;
  ContactsEmails({this.email});
  ContactsEmails.fromJson(Map<String, dynamic> json) {
    email = json['value'];
  }
}
