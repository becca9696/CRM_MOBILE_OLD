import 'package:crm_mobile/api/crm_company_network.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/crm_components/crm_company_tile.dart';
import 'package:crm_mobile/screens/crm_company_details_page.dart';
import 'package:flutter/material.dart';

class CrmCompanyPage extends StatefulWidget {
  const CrmCompanyPage({Key key}) : super(key: key);

  @override
  _CrmCompanyPageState createState() => _CrmCompanyPageState();
}

class _CrmCompanyPageState extends State<CrmCompanyPage> {
  Future<List<CrmCompanyApi>> _futureCompanies;
  final _textSearchController = TextEditingController();

  @override
  void initState() {
    _futureCompanies = fetchCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tCompanyTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _textSearchController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search_outlined),
                labelText: tCompanySearch,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder<List<CrmCompanyApi>>(
              future: _futureCompanies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<CrmCompanyApi> companies = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        itemCount: companies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CompanyListTile(
                            companyId: companies[index].id,
                            companyName: companies[index].companyName,
                            companyAddress: companies[index].address,
                            phone: companies[index].phones.isEmpty
                                ? null
                                : companies[index].phones.first,
                            companyEmail: companies[index].emails.isEmpty
                                ? null
                                : companies[index].emails.first,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CrmCompanyDetailsPage(
                                    companyId: companies[index].id,
                                    companyCode: companies[index].code,
                                    companyName: companies[index].companyName,
                                    companyDescription:
                                        companies[index].companyDescription,
                                    webSite: companies[index].webSite,
                                    companyAddress: companies[index].address,
                                    phone: companies[index].phones.isEmpty
                                        ? null
                                        : companies[index].phones.first,
                                    companyEmail:
                                        companies[index].emails.isEmpty
                                            ? null
                                            : companies[index].emails.first,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Text("${snapshot.error}");
                  }
                } else {
                  // By default show a loading spinner.
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _futureCompanies =
                fetchCompaniesStartsWith(_textSearchController.text.trim());
          });
        },
        child: const Icon(Icons.search_outlined),
        heroTag: "catalogSearch",
      ),
    );
  }
}
