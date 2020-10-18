import 'dart:typed_data';

import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:kunjika/reusable/text_form_field.dart';
import 'package:kunjika/services/master_pass.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetMasterPasswordPage extends StatefulWidget {
  @override
  _SetMasterPasswordPageState createState() => _SetMasterPasswordPageState();
}

class _SetMasterPasswordPageState extends State<SetMasterPasswordPage> {
  final _setMaterKey = TextEditingController();
  final _confirmMaterKey = TextEditingController();

  @override
  void dispose() {
    _confirmMaterKey.dispose();
    _setMaterKey.dispose();
    super.dispose();
  }

  void _setKey(BuildContext ctx, int key) async {
    if (_setMaterKey == null ||
        _confirmMaterKey == null ||
        _setMaterKey.value != _confirmMaterKey.value) {
      Toast.show(
        "Either Keys Are Null Or Did Not Match",
        ctx,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }
    if (_setMaterKey.value.text.length > 4) {
      Toast.show(
        "Only Four Digit Master Key Is Allowed",
        ctx,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }
    dynamic _provider = Provider.of<MasterPassword>(ctx, listen: false);
    _provider.setMasterPass(key);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 175,
                      width: 120,
                      child: SvgPicture.asset(
                        "assets/icons/security.svg",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "SET MASTER KEY",
                  style: TextStyle(fontSize: 20, letterSpacing: 1),
                ),
                SizedBox(height: 15),
                emailTextFormField(),
                SizedBox(height: 25),
                passwordTextFormField(),
                SizedBox(height: 55),
                GestureDetector(
                  onTap: () => _setKey(
                    context,
                    int.parse(_setMaterKey.value.text),
                  ),
                  child: createAcc(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createAcc() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.greenAccent.withOpacity(0.7),
        ),
        width: 250,
        height: 50,
        child: Center(
          child: Text(
            "Set Key",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  Widget emailTextFormField() {
    return CustomTextField(
      icon: Icons.lock,
      obscureText: true,
      keyboardType: TextInputType.number,
      textEditingController: _setMaterKey,
      hint: "Enter Master Key",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      obscureText: true,
      textEditingController: _confirmMaterKey,
      icon: Icons.lock,
      hint: "Confirm Master Key",
    );
  }
}
