import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModelBottomMenu extends StatefulWidget {
  final String webName;
  HomeModelBottomMenu({@required this.webName});
  @override
  _HomeModelBottomMenuState createState() => _HomeModelBottomMenuState();
}

class _HomeModelBottomMenuState extends State<HomeModelBottomMenu> {
  String _userid = "";
  String _pass = "";
  bool _noData = true;

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(widget.webName)) {
      setState(() {
        _noData = false;
      });
    }
    String data = prefs.getString(widget.webName);
    setState(() {
      _userid = data.split("||")[0];
      _pass = data.split("||")[1];
    });
  }

  @override
  initState() {
    _loadData();
    super.initState();
  }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Container(
      height: _height * .60,
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
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.webName.toLowerCase()}",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            thickness: 0.5,
          ),
          _noData
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "User Id",
                            style: _style(),
                          ),
                          Spacer(),
                          Text(
                            _userid,
                            style: _style(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: _style(),
                          ),
                          Spacer(),
                          Text(
                            _pass,
                            style: _style(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    "no data available",
                    style: _style(),
                  ),
                )
        ],
      ),
    );
  }

  TextStyle _style() => TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 25,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      );
}
