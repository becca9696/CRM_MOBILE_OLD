import 'package:crm_mobile/api/crm_company_network.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_alert_dialog.dart';
import 'package:crm_mobile/crm_components/crm_comapany_avatar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'crm_company_contacts_page.dart';

class CrmCompanyDetailsPage extends StatelessWidget {
  final int companyId;
  final String companyCode;
  final String companyName;
  final String companyDescription;
  final String companyAddress;
  final String province;
  final String region;
  final String state;
  final String zipCode;
  final String webSite;
  final Phones phone;
  final Emails companyEmail;

  CrmCompanyDetailsPage({
    this.companyCode,
    this.companyId,
    this.companyName,
    this.companyDescription,
    this.companyAddress,
    this.province,
    this.region,
    this.state,
    this.zipCode,
    this.webSite,
    this.phone,
    this.companyEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Codice: $companyCode"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tPaddingAll),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //padding: const EdgeInsets.all(50),
          children: [
            Center(
              child: CompanyAvatar(
                companyName: companyName,
                size: tCircleAvatarSize / 2,
              ),
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: "Codice",
                border: OutlineInputBorder(),
              ),
              initialValue: companyCode,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city_outlined),
                labelText: "Ragione Sociale",
                border: OutlineInputBorder(),
              ),
              initialValue: companyName,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                labelText: "Indirizzo",
                border: OutlineInputBorder(),
              ),
              initialValue: companyAddress,
            ),
            const SizedBox(height: tSizedBoxHeight),
            TextFormField(
              readOnly: true,
              maxLines: 5,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                labelText: "Descrizione",
                border: OutlineInputBorder(),
              ),
              initialValue: companyDescription,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: tPaddingSymmetricHorizontal,
          vertical: tPaddingSymmetricVertical,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
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
              child: const Icon(Icons.perm_contact_calendar),
              heroTag: "sms",
              backgroundColor: Colors.purple[800],
            ),
            FloatingActionButton(
              onPressed: () {
                if (companyEmail != null) {
                  launch("mailto:${companyEmail.email}");
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
              child: const Icon(Icons.alternate_email_outlined),
              heroTag: "E-Mail",
              backgroundColor: Colors.blue[800],
            ),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.navigation_outlined),
              heroTag: "map",
              backgroundColor: Colors.green[800],
            ),
            FloatingActionButton(
              onPressed: () {
                if (webSite.trim().isNotEmpty) {
                  launch("https:$webSite");
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CrmAlertDialog(
                      companyName: companyName,
                      alertMessage: tNoCompanyWebSite,
                    ),
                    barrierDismissible: false,
                  );
                }
              },
              child: const Icon(Icons.open_in_browser_outlined),
              heroTag: "web_site",
              backgroundColor: Colors.yellow[800],
            ),
            FloatingActionButton(
              onPressed: () {
                if (phone != null) {
                  launch("tel:${phone.phoneNumber}");
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
