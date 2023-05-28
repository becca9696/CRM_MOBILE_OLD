import 'package:crm_mobile/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class CrmProfilePage extends StatelessWidget {
  const CrmProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tProfileTitle),
      ),
      body: FutureBuilder(
        future: SessionManager().get('crmMeData'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data['avatar'],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: snapshot.data['name'],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "E-Mail",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: snapshot.data['email'],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        labelText: "User ID",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: snapshot.data['userId'].toString(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.admin_panel_settings_outlined),
                        labelText: "Admin",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: snapshot.data['isAdmin'].toString(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.shopping_basket_outlined),
                        labelText: "Commerciale",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: snapshot.data['isAgent'].toString(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
