import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/nav/mainpage.dart';

class MyAppWithBottomNavBar extends StatefulWidget {
  @override
  _SportsListState createState() => _SportsListState();
}

class _SportsListState extends State<MyAppWithBottomNavBar> {
  bool _showSportSelection = false;

  // Define the toggleThemeMode function
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, // Set the current theme mode
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: secondarycolor,
          title: Row(
            children: [
              const Icon(
                IconData(0xe5f2, fontFamily: 'MaterialIcons'),
                size: 40,
                color: nextcolor,
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showSportSelection = !_showSportSelection;
                      });
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'SOCCER',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                CupertinoIcons.search,
                size: 30,
                color: nextcolor,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        body: Stack(
          children: [
            MainScreenWithTopNavBar(
              toggleThemeMode:
                  _toggleThemeMode, // Pass the toggleThemeMode function
            ),
          ],
        ),
      ),
    );
  }
}
