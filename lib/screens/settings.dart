import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "package:HungryHippos/screens/limit.dart";
import "package:HungryHippos/screens/limits.dart";
import "package:HungryHippos/screens/dark_theme_provider.dart";

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<Limit> _limitList = Limits.getLimits();
  List<DropdownMenuItem<Limit>> _limitDropdown;
  Limit _selectedLimit;

  @override
  void initState() {
    _limitDropdown = buildDropdownMenuItems(_limitList);
    _selectedLimit = Limits.getSelectedLimit();
    super.initState();
  }

  List<DropdownMenuItem<Limit>> buildDropdownMenuItems(List limits) {
    List<DropdownMenuItem<Limit>> items = List();
    for (Limit limit in limits) {
      items.add(
        DropdownMenuItem(value: limit, child: Text(limit.nums.toString())),
      );
    }
    return items;
  }

  onChangeDropdownItem(Limit selectedLimit) {
    setState(() {
      _selectedLimit = selectedLimit;
      Limits.setSelectedLimit(selectedLimit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: _screenSize.height * 0.05),
            child: Center(
              child: Text(
                'App made by Yang Liu',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: _screenSize.height * 0.05),
          child: Text(
            'Set the restaurant list limit here',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          alignment: Alignment(0.0, 0.0),
        ),
        Container(
          child: DropdownButton(
            value: _selectedLimit,
            items: _limitDropdown,
            onChanged: onChangeDropdownItem,
          ),
          alignment: Alignment(0.0, 0.0),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: _screenSize.height * 0.05),
            child: Center(
              child: Text(
                'Tick the box for dark/light mode!',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Checkbox(
            value: themeChange.darkTheme, 
            onChanged: (bool value) {
            themeChange.darkTheme = value;
          })
        ),
      ])),
    );
  }
}
