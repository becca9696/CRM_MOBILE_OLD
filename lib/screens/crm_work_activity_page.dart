import 'package:crm_mobile/api/crm_activity_network.dart';
import 'package:crm_mobile/constants/sizes.dart';
import 'package:crm_mobile/crm_components/crm_activity_tile.dart';
import 'package:crm_mobile/crm_components/crm_no_activity.dart';
import 'package:crm_mobile/constants/text_strings.dart';
import 'package:crm_mobile/screens/crm_work_activity_page_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CrmWorkActivityPage extends StatefulWidget {
  const CrmWorkActivityPage({Key key}) : super(key: key);

  @override
  _CrmWorkActivityPageState createState() => _CrmWorkActivityPageState();
}

class _CrmWorkActivityPageState extends State<CrmWorkActivityPage> {
  Future<List<CrmActivity>> _futureActivities;
  DateFormat formatter;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    _selectedDay = DateTime.now();
    print("***************\n\n\n" +
        _selectedDay.toString() +
        "\n\n\n\n*********");
    formatter = DateFormat('yyyy-MM-dd');
    final String formattedTodayDate = formatter.format(_selectedDay);
    _futureActivities = fetchDayActivities(formattedTodayDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(tCalendarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: tPaddingSymmetricHorizontal / 10),
        child: Column(
          children: [
            TableCalendar(
              locale: 'it_IT',
              firstDay: DateTime(2010),
              lastDay: DateTime(2099),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  //Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    formatter = DateFormat('yyyy-MM-dd');
                    final String formattedTodayDate =
                        formatter.format(_selectedDay);
                    _futureActivities = fetchDayActivities(formattedTodayDate);
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<CrmActivity>>(
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
                                description: activities[index].description,
                                description2: activities[index].description2,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrmWorkActivityDetails(
                companyName: "",
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        heroTag: "new_activity",
      ),
    );
  }
}
