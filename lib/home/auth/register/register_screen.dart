import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import '/dialog_utils.dart';
import '/firebase_utils.dart';
import '/home/auth/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/home/home_screen.dart';
import '/model/my_user.dart';
import '/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.su),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      AppLocalizations.of(context)!.su,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        color: appcolor.primarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                      CustomTextFormField(
                        label: AppLocalizations.of(context)!.user,
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.eu;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        label: AppLocalizations.of(context)!.email,
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.ee;
                          }
                           final bool emailValid = RegExp(
                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(text);
                           if (!emailValid) {
                             return AppLocalizations.of(context)!.ee;
                           }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextFormField(
                        label: AppLocalizations.of(context)!.pass,
                        controller: passController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.ep;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(context)!.psix;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      CustomTextFormField(
                        label: AppLocalizations.of(context)!.cop,
                        controller: confController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.ecp;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(context)!.psix;
                          }
                          if (text != passController.text) {
                            return "password doesn't match";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              onPressed: () {
                                register(context);
                              },
                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                appcolor.primarycolor,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                              child: Text(
                                AppLocalizations.of(context)!.su,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: appcolor.whitecolor),
                              ))),
                    ],
                  )),
            ],
          ),
        ));
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
      try {
        DialogUtils.showLoading(
    context: (context),
    loadingLabel: 'loading...',
    barrierDismissible: false);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        print('before DB');

        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        print('after DB');
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            contents: 'Register Successfully',
            title: AppLocalizations.of(context)!.suc,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              contents: 'The password provided is too weak',
              title: AppLocalizations.of(context)!.e,
              posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              contents: 'an account already exists for that email',
              title: AppLocalizations.of(context)!.e,
              posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            contents: e.toString(),
            title: AppLocalizations.of(context)!.e,
            posActionName: AppLocalizations.of(context)!.ok);
      }
    }
  }
}
