import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.light);
                },
                child: provider.appMode==ThemeMode.light?
                getSelectedItemWidget(AppLocalizations.of(context)!.light):
                getUnselectedItemWidget(AppLocalizations.of(context)!.light),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.dark);
                },
                child: provider.appMode==ThemeMode.dark?
                getSelectedItemWidget(AppLocalizations.of(context)!.dark):
                getUnselectedItemWidget(AppLocalizations.of(context)!.dark),
                /*Icon(
                  Icons.check,
                  size: 30,*/
              ),
            ),
          ],
        ));
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appcolor.primarycolor),
        ),
        const Icon(Icons.check, size: 30, color: appcolor.primarycolor)
      ],
    );
  }

  Widget getUnselectedItemWidget(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
