import 'package:flutter/material.dart';
import 'package:kunjika/reusable/text_form_field.dart';
import 'package:kunjika/screens/home_page.dart';
import 'package:kunjika/services/user_passwords.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddNewPassword extends StatefulWidget {
  static const routeName = "/addNewPassword";

  @override
  _AddNewPasswordState createState() => _AddNewPasswordState();
}

class _AddNewPasswordState extends State<AddNewPassword> {
  final _websiteName = TextEditingController();
  final _userId = TextEditingController();
  final _password = TextEditingController();

  void _addNewDetail(BuildContext ctx) async {
    if (_websiteName.value.text.isEmpty ||
        _userId.value.text.isEmpty ||
        _password.value.text.isEmpty) {
      Toast.show(
        "Please Add Relevant Details",
        ctx,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }
    dynamic _provider = Provider.of<UserPasswords>(ctx, listen: false);

    bool isSaved = await _provider.addNewData(
      webName: _websiteName.value.text.toString(),
      userId: _userId.value.text.toString(),
      pass: _password.value.text.toString(),
    );
    if (isSaved) {
      Navigator.of(context).popAndPushNamed(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.chevron_left,
                            size: 35,
                          ),
                          Positioned(
                            left: 9,
                            child: Icon(
                              Icons.chevron_left,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              websiteNameTextFormField(),
              SizedBox(height: 20),
              userIdTextFormField(),
              SizedBox(height: 20),
              passwordTextFormField(),
              Spacer(),
              GestureDetector(
                onTap: () => _addNewDetail(context),
                child: savePassword(),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget savePassword() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.greenAccent.withOpacity(0.7),
        ),
        width: 250,
        height: 50,
        child: Center(
          child: Text(
            "Save Password",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  Widget websiteNameTextFormField() {
    return CustomTextField(
      icon: Icons.lock,
      keyboardType: TextInputType.text,
      textEditingController: _websiteName,
      hint: "Enter Website Name",
    );
  }

  Widget userIdTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: _userId,
      icon: Icons.lock,
      hint: "Enter User ID",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: _password,
      obscureText: true,
      icon: Icons.lock,
      hint: "Enter Password",
    );
  }
}
