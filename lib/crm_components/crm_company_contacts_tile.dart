import 'package:crm_mobile/api/crm_company_contacts_network.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyContactsTile extends StatelessWidget {
  final int companyId;

  final String contactName;
  final String contactSurname;
  final int ownerId;
  final ContactsPhones contactPhone;
  final ContactsEmails contactEmail;
  final onPress;

  CompanyContactsTile({
    this.companyId,
    this.contactPhone,
    this.contactName,
    this.ownerId,
    this.contactSurname,
    this.contactEmail,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("$contactSurname $contactName"),
      subtitle: contactPhone == null
          ? const Text("")
          : Text(contactPhone.phoneNumber),
      leading: CircleAvatar(
        child: Text(
          contactName.isNotEmpty
              ? contactName.substring(0, 1).toUpperCase() +
                  contactSurname.substring(0, 1).toUpperCase()
              : contactSurname.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      trailing: IconButton(
        onPressed: onPress,
        icon: const Icon(Icons.navigate_next_outlined),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (contactPhone != null) {
                  launch("sms:" + contactPhone.phoneNumber);
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
            ),
            IconButton(
              icon: const Icon(
                Icons.alternate_email_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (contactEmail != null) {
                  launch('mailto:${contactEmail.email}');
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
            ),
            IconButton(
              icon: const Icon(
                Icons.call_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (contactPhone != null) {
                  launch("tel:" + contactPhone.phoneNumber);
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
            ),
          ],
        ),
      ],
    );
  }
}
