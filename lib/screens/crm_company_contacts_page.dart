import 'package:crm_mobile/api/crm_company_contacts_network.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_company_contacts_tile.dart';
import 'package:crm_mobile/screens/crm_company_contacts_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrmCompanyContactsPage extends StatefulWidget {
  final int companyId;
  final String companyName;

  CrmCompanyContactsPage({
    this.companyId,
    this.companyName,
  });

  @override
  _CrmCompanyContactsPageState createState() => _CrmCompanyContactsPageState();
}

class _CrmCompanyContactsPageState extends State<CrmCompanyContactsPage> {
  Future<List<CrmCompanyContacs>> _futureContacts;

  @override
  void initState() {
    _futureContacts = fetchCompanyContactsById(widget.companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contatti di ${widget.companyName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<List<CrmCompanyContacs>>(
          future: _futureContacts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<CrmCompanyContacs> contacts = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CompanyContactsTile(
                      contactName: contacts[index].name,
                      companyId: contacts[index].companyId,
                      contactSurname: contacts[index].surname,
                      ownerId: contacts[index].ownerId,
                      contactPhone: contacts[index].phones.isEmpty
                          ? null
                          : contacts[index].phones.first,
                      contactEmail: contacts[index].emails.isEmpty
                          ? null
                          : contacts[index].emails.first,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CrmCompanyContactsDetails(
                              companyName: widget.companyName,
                              contactName: contacts[index].name.isEmpty
                                  ? ''
                                  : contacts[index].name,
                              companyId: contacts[index].companyId,
                              contactSurname: contacts[index].surname,
                              ownerId: contacts[index].ownerId,
                              contactPhone: contacts[index].phones.isEmpty
                                  ? null
                                  : contacts[index].phones.first,
                              contactEmail: contacts[index].emails.isEmpty
                                  ? null
                                  : contacts[index].emails.first,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Text("${snapshot.error}");
              }
            } else {
              return CircularProgressIndicator();
            }
            // By default show a loading spinner.
          },
        ),
      ),
    );
  }
}
