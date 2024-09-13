import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/home/task_list/task_list_item.dart';
import 'package:todoappp/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context,listen:true);
    var userProvider = Provider.of<UserProvider>(context,listen:true);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
    }

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            listProvider.changeSelectDate(selectedDate,userProvider.currentUser!.id);
            // Handle date change
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    appcolor.primarycolor,
                    Color.fromARGB(255, 145, 190, 220),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 1),
        Expanded(
          child: listProvider.tasksList.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.nat))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: listProvider.tasksList[index],
                    );
                  },
                  itemCount: listProvider.tasksList.length,
                ),
        ),
      ],
    );
  }
}
 /* void getAllTasksFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }*/


