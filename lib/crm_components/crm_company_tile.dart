import 'package:crm_mobile/api/crm_company_network.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_alert_dialog.dart';
import 'package:crm_mobile/screens/crm_company_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'crm_comapany_avatar.dart';

class CompanyListTile extends StatelessWidget {
  final int companyId;
  final String companyName;
  final String companyAddress;
  final Phones phone;
  final String webSite;
  final Emails companyEmail;
  final Function onPress;

  CompanyListTile({
    this.companyId,
    this.companyName,
    this.phone,
    this.webSite,
    this.companyAddress,
    this.companyEmail,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(companyName),
      subtitle: phone == null
          ? const Text("")
          : Text(
              phone.phoneNumber,
            ),
      leading: CompanyAvatar(
        companyName: companyName,
        size: 20.0,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.blueAccent,
        ),
        onPressed: onPress,
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.perm_contact_calendar_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrmCompanyContactsPage(
                      companyId: companyId,
                      companyName: companyName,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (companyEmail != null) {
                  launch("sms:" + phone.phoneNumber);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: companyName,
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
                if (companyEmail != null) {
                  launch('mailto:${companyEmail.email}');
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: companyName,
                      alertMessage: tNoCompanyEMail,
                    ),
                    barrierDismissible: false,
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.navigation_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                //MapUtils.openMap(companyAddress);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.call_outlined,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (phone != null) {
                  launch("tel:" + phone.phoneNumber);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: companyName,
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
