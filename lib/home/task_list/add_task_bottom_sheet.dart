import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/providers/user_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  String description = '';
  var selectDate = DateTime.now();
  String title = '';
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: appcolor.whitecolor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.entert;
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.entert,
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.enterd;
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText:AppLocalizations.of(context)!.enterd,
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.select_date,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 3),
                          InkWell(
                            onTap: showCalendar,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: appcolor.whitecolor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        if (!isAdding) addTask();
                      },
                      backgroundColor: appcolor.primarycolor,
                      child: Icon(
                        isAdding ? Icons.check : Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    var listProvider = Provider.of<ListProvider>(context,listen:false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    if (formKey.currentState?.validate() == true) {
      setState(() {
        isAdding = true;
      });

      Task task = Task(
        dateTime: selectDate,
        title: title,
        description: description,
      );

      FirebaseUtils.addTaskToFirebase(task, userProvider.currentUser!.id)
          .then((value) {
        print(AppLocalizations.of(context)!.tasksucc);
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);
      }).timeout(const Duration(seconds: 1), onTimeout: () {
        print(AppLocalizations.of(context)!.tasksucc);
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);
      });

      (value) {
        Provider.of<ListProvider>(context, listen: true)
            .getAllTasksFromFireStore(userProvider.currentUser!.id);
        setState(() {
          isAdding = true;
        });
        Navigator.pop(context);
      };
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onSurface: appcolor.primarycolor,
            ),
            dialogBackgroundColor: appcolor.whitecolor,
          ),
          child: child!,
        );
      },
    );
    if (chosenDate != null) {
      setState(() {
        selectDate = chosenDate;
      });
    }
  }
}
