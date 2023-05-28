import 'package:crm_mobile/api/crm_activity_network.dart';
import 'package:crm_mobile/crm_components/crm_activity_tile.dart';
import 'package:crm_mobile/crm_components/crm_no_activity.dart';
import 'package:crm_mobile/constants/image_strings.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/screens/crm_catalog_page.dart';
import 'package:crm_mobile/screens/crm_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';

import 'crm_company_page.dart';
import 'crm_login_page.dart';
import 'crm_work_activity_page.dart';

class CrmHomePage extends StatefulWidget {
  const CrmHomePage({Key key}) : super(key: key);

  @override
  _CrmHomePageState createState() => _CrmHomePageState();
}

class _CrmHomePageState extends State<CrmHomePage> {
  Future<List<CrmActivity>> _futureActivities;
  DateFormat formatter;
  DateTime _selectedValue;

  @override
  Future<void> initState() {
    _selectedValue = DateTime.now();
    formatter = DateFormat('yyyy-MM-dd');
    final String formattedTodayDate = formatter.format(_selectedValue);
    _futureActivities = fetchDayActivities(formattedTodayDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tAppBarTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: SessionManager().get('crmMeData'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data['name'].toString()),
                      accountEmail: Text(snapshot.data['email'].toString()),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data['avatar'],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_outlined),
              title: const Text(tItem6),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmProfilePage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.perm_contact_calendar_outlined),
              title: const Text(tItem1),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmCompanyPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text(tItem2),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmWorkActivityPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: const Text(tItem3),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmCatalogPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_basket_outlined),
              title: const Text(tItem4),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmLoginPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home_repair_service_outlined),
              title: const Text(tItem5),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmLoginPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(tItem7),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrmLoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //Meteo e Grafici
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Image(image: AssetImage(tSun)),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Image(image: AssetImage(tChart)),
                ),
              ),
            ],
          ),
          const Divider(),
          //Attività di oggi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder<List<CrmActivity>>(
              future: _futureActivities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<CrmActivity> activities = snapshot.data;
                    return activities.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: activities.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ActivityListTile(
                                subject: activities[index].subject,
                                companyId: activities[index].companyId,
                                activityDate: activities[index].activityDate,
                                activityEndDate:
                                    activities[index].activityEndDate,
                                type: activities[index].type,
                                subTypeId: activities[index].subTypeId,
                                toDo: activities[index].toDo,
                                activityId: activities[index].id,
                                idCompanion: activities[index].idCompanion,
                                description:
                                    activities[index].description.isEmpty
                                        ? ""
                                        : activities[index].description,
                                description2:
                                    activities[index].description2.isEmpty
                                        ? ""
                                        : activities[index].description2,
                              );
                            },
                          )
                        : const CrmNoActivityText();
                  } else {
                    return Text("${snapshot.error}");
                  }
                } else {
                  return const CircularProgressIndicator();
                }
                // By default show a loading spinner.
              },
            ),
          ),
          /*const Divider(),
          //Interventi di oggi
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Center(child: Text('Intervento')),
                );
              },
            ),
          ),
          const Divider(),*/
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedValue = DateTime.now();
            formatter = DateFormat('yyyy-MM-dd');
            final String formattedTodayDate = formatter.format(_selectedValue);
            _futureActivities = fetchDayActivities(formattedTodayDate);
          });
        },
        child: const Icon(Icons.refresh_outlined),
        heroTag: "refresh_home_page",
      ),
    );
  }
}
