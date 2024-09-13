//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String loadingLabel,
      bool barrierDismissible = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 8),
                Text(loadingLabel,style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),)
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String contents,
      String title = 'Title',
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style:
            Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,),)
        ),
      );
    }
    if (negActionName != null) {
      actions.add(ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            /*if (negAction != null) {
              negAction.call();
            }*/
            negAction?.call();
          },
          child: Text(
            negActionName,
             style:
             Theme.of(context).textTheme.labelLarge?.copyWith(
              color: 
              Theme.of(context).colorScheme.secondary,))));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            contents,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: actions,
        );
      },
    );
  }
}
