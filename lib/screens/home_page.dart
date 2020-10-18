import 'package:flutter/material.dart';
import 'package:kunjika/reusable/bottom_sheet.dart';
import 'package:kunjika/reusable/text_form_field.dart';
import 'package:kunjika/screens/add_password.dart';
import 'package:kunjika/services/master_pass.dart';
import 'package:kunjika/services/user_passwords.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final _password = TextEditingController();

  Widget build(BuildContext context) {
    dynamic _provider = Provider.of<UserPasswords>(context, listen: false);

    _showBottomSheet(String webName) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return HomeModelBottomMenu(
            webName: webName,
          );
        },
      );
    }

    Widget checkPassword(String webName) => GestureDetector(
          onTap: () async {
            bool istrue =
                await Provider.of<MasterPassword>(context, listen: false)
                    .validateMaster(_password.value.text.toString());
            if (istrue) {
              _password.dispose();
              Navigator.of(context).pop();
              _showBottomSheet(webName);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.greenAccent.withOpacity(0.7),
            ),
            width: 250,
            height: 50,
            child: Center(
              child: Text(
                "Validate Master Key",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );

    Widget masterKeyTextFormField() {
      return CustomTextField(
        icon: Icons.lock,
        keyboardType: TextInputType.text,
        textEditingController: _password,
        hint: "Enter Master Key To See",
      );
    }

    _checkMasterKey(String webName) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(50.0),
                topRight: const Radius.circular(50.0),
              ),
            ),
            child: Column(
              children: [
                masterKeyTextFormField(),
                SizedBox(height: 20),
                checkPassword(webName)
              ],
            ),
          );
        },
      );
    }

    Widget passwordCard(String webName) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              _checkMasterKey(webName);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff96DEDA),
                    Color(0xff50C9C3),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text(
                  webName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Stack(
                  children: [
                    Icon(Icons.chevron_right),
                    Positioned(
                      left: 5,
                      child: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

    Widget settingsRow() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.settings,
                size: 35,
              ),
            ),
          ],
        );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              settingsRow(),
              Expanded(
                child: FutureBuilder(
                  future: _provider.loadData(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(
                              child: Text("Loading..."),
                            )
                          : ListView.builder(
                              itemCount: _provider.passwords.length,
                              itemBuilder: (context, index) {
                                return passwordCard(
                                  _provider.passwords[index].websiteName,
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddNewPassword.routeName),
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
    );
  }
}
