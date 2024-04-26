import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/screens/homescreen/home_screen.dart';
import 'package:offline_ai/screens/models/model_fetcher.dart';
import 'package:offline_ai/screens/settings.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreenWithTopNavBar extends StatefulWidget {
  final Function toggleThemeMode;

  const MainScreenWithTopNavBar({Key? key, required this.toggleThemeMode})
      : super(key: key);

  @override
  _MainScreenWithTopNavBarState createState() =>
      _MainScreenWithTopNavBarState();
}

class _MainScreenWithTopNavBarState extends State<MainScreenWithTopNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      TagFetcher(), // This line cannot be fixed without additional context
      SettingsScreen(toggleThemeMode: widget.toggleThemeMode),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
        title: ("Chat"),
        activeColorPrimary: othercolor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.format_line_spacing_sharp),
        title: ("MOdels"),
        activeColorPrimary: othercolor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_applications_outlined),
        title: ("Setting"),
        activeColorPrimary: othercolor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: nextcolor, // Overall background color
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      navBarStyle: NavBarStyle.style6,
      navBarHeight: 60.0,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
    );
  }
}
