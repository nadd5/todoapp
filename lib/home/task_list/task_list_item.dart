import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    String deleteText = AppLocalizations.of(context)!.delete;
    String delText = AppLocalizations.of(context)!.del;
    String isDoneText = AppLocalizations.of(context)!.is_done;

    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                    task, userProvider.currentUser!.id
                ).then((value) {
                  print(delText);
                  listProvider.removeTaskFromList(task);
                  listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
                }).timeout(const Duration(seconds: 1), onTimeout: () {
                  print(delText);
                  listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
                });
              },
              backgroundColor: appcolor.redcolor,
              foregroundColor: appcolor.whitecolor,
              icon: Icons.delete,
              label: deleteText,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => _showEditTaskDialog(context, task, listProvider),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appcolor.whitecolor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: 4,
                  color: appcolor.primarycolor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: task.isDone
                              ? appcolor.greencolor
                              : appcolor.primarycolor,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: task.isDone
                              ? appcolor.greencolor
                              : appcolor.primarycolor,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: task.isDone
                        ? Colors.transparent
                        : appcolor.primarycolor,
                  ),
                  child: task.isDone
                      ? Text(
                    isDoneText,
                    style: const TextStyle(
                        color: appcolor.greencolor,
                        fontWeight: FontWeight.bold),
                  )
                      : IconButton(
                    onPressed: () {
                      _markTaskAsDone(context, task, listProvider);
                    },
                    icon: const Icon(Icons.check, size: 35),
                    color: appcolor.whitecolor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditTaskDialog(
      BuildContext context, Task task, ListProvider listProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTitle = task.title;
        String updatedDescription = task.description;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: appcolor.whitecolor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.edit_task,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    updatedTitle = value;
                  },
                  controller: TextEditingController(text: task.title),
                  style: const TextStyle(color: appcolor.blackcolor, fontSize: 12),
                  cursorColor: appcolor.primarycolor,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.entert,
                    filled: true,
                    fillColor: Colors.transparent,
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: appcolor.primarycolor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: appcolor.primarycolor),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    updatedDescription = value;
                  },
                  controller: TextEditingController(text: task.description),
                  style: const TextStyle(color: appcolor.blackcolor, fontSize: 12),
                  cursorColor: appcolor.primarycolor,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.enterd,
                    filled: true,
                    fillColor: Colors.transparent,
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: appcolor.primarycolor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: appcolor.primarycolor),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(color: appcolor.primarycolor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        task.title = updatedTitle;
                        task.description = updatedDescription;
                        var userProvider = Provider.of<UserProvider>(context, listen: false);
                        FirebaseUtils.updateTaskInFirebase(task, userProvider.currentUser!.id);
                        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: const TextStyle(color: appcolor.primarycolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _markTaskAsDone(BuildContext context, Task task, ListProvider listProvider) {
    task.isDone = true;
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    FirebaseUtils.updateTaskInFirebase(task, userProvider.currentUser!.id);
    listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
  }
}
