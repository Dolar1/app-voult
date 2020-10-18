import 'package:flutter/material.dart';
import 'package:kunjika/screens/add_password.dart';
import 'package:kunjika/screens/set_master_pass.dart';
import 'package:kunjika/services/master_pass.dart';
import 'package:kunjika/services/user_passwords.dart';
import 'package:provider/provider.dart';
import 'package:kunjika/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          MasterPassword _auth = MasterPassword();
          _auth.init();
          return _auth;
        }),
        ChangeNotifierProvider(create: (_) {
          UserPasswords _data = UserPasswords();
          return _data;
        }),
      ],
      child: Consumer<MasterPassword>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Kunjika',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isMasterPrznt
              ? HomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : SetMasterPasswordPage(),
                ),
          routes: {
            AddNewPassword.routeName: (ctx) => AddNewPassword(),
            HomePage.routeName: (ctx) => HomePage(),
          },
        ),
      ),
    );
  }
}
