import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/appcolor.dart';
import '/dialog_utils.dart';
import '/firebase_utils.dart';
import '/home/auth/custom_text_form_field.dart';
import '/home/auth/register/register_screen.dart';
import '/home/home_screen.dart';
import '/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  
  static const String routeName = 'Login_screen';
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late UserProvider userProvider;

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.login),
          backgroundColor: appcolor.primarycolor,
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
                          AppLocalizations.of(context)!.wb,
                          textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        color: appcolor.blackcolor,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
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
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              onPressed: () {
                                login(context);
                              },
                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                appcolor.primarycolor,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: appcolor.whitecolor),
                              )
                              )
                              ),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Text(AppLocalizations.of(context)!.su,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: appcolor.primarycolor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          )
                                          )
                                          )
                                          ),
                    ],
                  )),
            ],
          ),
        ));
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
         DialogUtils.showLoading(
            context: context,
            loadingLabel: AppLocalizations.of(context)!.wait,
           barrierDismissible: false);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text);

        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        print(credential.user?.uid ?? "");
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

        userProvider.updateUser(user);
         DialogUtils.hideLoading(context);
         DialogUtils.showMessage(
            context: context,
            contents: AppLocalizations.of(context)!.lsuc,
           title: AppLocalizations.of(context)!.suc,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == AppLocalizations.of(context)!.inval) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              contents:
                  "Supplied auth credential is incorrect,malformed or has expired",
              title: AppLocalizations.of(context)!.e,
              posActionName:AppLocalizations.of(context)!.ok);
        } 
        else if (e.code == AppLocalizations.of(context)!.wP) {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            contents: e.toString(),
            title: 'Error',
            posActionName: AppLocalizations.of(context)!.ok);
      }
    }
  }
}
