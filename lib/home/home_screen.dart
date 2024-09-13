import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/home/auth/login/login_screen.dart';
import 'package:todoappp/home/task_list/add_task_bottom_sheet.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/home/settings/settings_tab.dart';
import 'package:todoappp/home/task_list/task_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
          title: Text(
            selectedIndex == 0
                ? "${AppLocalizations.of(context)!.app_title}{${userProvider.currentUser!.name}}"
                : AppLocalizations.of(context)!.settings,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  listProvider.tasksList = [];
                  //userProvider.currentUser = null;
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                icon: const Icon(Icons.logout))
          ]),
      bottomNavigationBar: BottomAppBar(
        color: appcolor.whitecolor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list, size: 24),
              label: AppLocalizations.of(context)!.task_list,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings, size: 24),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskBottomSheet();
        },
        child: const Icon(Icons.add, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? const TaskListTab() : const SettingsTab(),
    );
  }

  void showTaskBottomSheet() {
    showCustomBottomSheet(context, const AddTaskBottomSheet());
  }

  void showCustomBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: appcolor.primarycolor, width: 2),
      ),
      context: context,
      builder: (context) => child,
    );
  }
}
