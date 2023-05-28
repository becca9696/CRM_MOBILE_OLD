import 'package:crm_mobile/api/crm_company_contacts_network.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CrmCompanyContactsDetails extends StatelessWidget {
  final String companyName;
  final int companyId;
  final String contactName;
  final String contactSurname;
  final int ownerId;
  final ContactsPhones contactPhone;
  final ContactsEmails contactEmail;

  CrmCompanyContactsDetails({
    this.companyName,
    this.companyId,
    this.contactPhone,
    this.contactName,
    this.ownerId,
    this.contactSurname,
    this.contactEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: contactName.isEmpty
            ? Text(contactSurname)
            : Text("$contactSurname $contactName"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tPaddingAll),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //padding: const EdgeInsets.all(8),
          children: [
            Center(
              child: CircleAvatar(
                maxRadius: tCircleAvatarSize / 2,
                child: Text(
                  contactName.isNotEmpty
                      ? contactName.substring(0, 1).toUpperCase() +
                          contactSurname.substring(0, 1).toUpperCase()
                      : contactSurname.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.red,
                ),
                labelText: "Codice",
                border: OutlineInputBorder(),
              ),
              initialValue: "TODO: CODICE CONTATTO",
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Cognome Nome",
                border: OutlineInputBorder(),
              ),
              initialValue: "$contactSurname $contactName",
            ),
            const SizedBox(height: tSizedBoxHeight),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (contactEmail != null) {
                  launch("mailto:${contactEmail.email}");
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: contactName.isNotEmpty
                          ? "$contactSurname $contactName"
                          : contactSurname,
                      alertMessage: tNoCompanyEMail,
                    ),
                    barrierDismissible: false,
                  );
                }
              },
              child: const Icon(Icons.alternate_email_outlined),
              heroTag: "E-Mail",
              backgroundColor: Colors.blue[800],
            ),
            FloatingActionButton(
              onPressed: () {
                if (contactPhone != null) {
                  launch("tel:${contactPhone.phoneNumber}");
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: contactName.isNotEmpty
                          ? "$contactSurname $contactName"
                          : contactSurname,
                      alertMessage: tNoCompanyNumber,
                    ),
                    barrierDismissible: false,
                  );
                }
              },
              child: const Icon(Icons.call_outlined),
              backgroundColor: Colors.orange[800],
              heroTag: "call",
            ),
          ],
        ),
      ),
    );
  }
}
