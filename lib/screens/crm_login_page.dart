import 'package:crm_mobile/api/crm_auth_network.dart';
import 'package:crm_mobile/constants/image_strings.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/screens/crm_home_page.dart';
import 'package:flutter/material.dart';

class CrmLoginPage extends StatefulWidget {
  const CrmLoginPage({Key key}) : super(key: key);

  @override
  _CrmLoginPageState createState() => _CrmLoginPageState();
}

class _CrmLoginPageState extends State<CrmLoginPage> {
  CrmAuthApi crmAuthApi;
  bool isLoading = false;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(tCrmLogo),
                    height: size.height * 0.2,
                  ),
                ),
                Form(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "E-Mail",
                            hintText: tEmail,
                            border: OutlineInputBorder(),
                          ),
                          controller: _controllerUsername,
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint),
                            labelText: "Password",
                            hintText: tPassword,
                            border: OutlineInputBorder(),
                          ),
                          controller: _controllerPassword,
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        SizedBox(
                          width: double.infinity,
                          child: !isLoading
                              ? ElevatedButton(
                                  child: Text(tLogin.toUpperCase()),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await crmLogin(
                                            _controllerUsername.text.trim(),
                                            _controllerPassword.text.trim())
                                        .then(
                                      (crmAuthData) {
                                        if (crmAuthData == true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CrmHomePage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Username o Password non validi"),
                                            ),
                                          );
                                        }
                                      },
                                    );

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: !isLoading
                              ? ElevatedButton(
                                  child: Text(tLoginAdmin.toUpperCase()),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    // Api
                                    //_controllerUsername.text.trim(),
                                    //                                             _controllerPassword.text.trim()
                                    await crmLogin("admin", "Progstud01!.")
                                        .then(
                                      (crmAuthData) {
                                        if (crmAuthData == true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CrmHomePage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Username o Password non validi"),
                                            ),
                                          );
                                        }
                                      },
                                    );

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
