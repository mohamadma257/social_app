import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/pages/add.dart';
import 'package:social_media/pages/home.dart';
import 'package:social_media/pages/profile.dart';
import 'package:social_media/pages/search.dart';
import 'package:social_media/providers/user_provider.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageCon = PageController();
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).isLoad
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: PageView(
              controller: pageCon,
              children: [
                HomePage(),
                AddPage(),
                SearchPage(),
                ProfilePage(),
              ],
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (value) => setState(() {
                currentIndex = value;
                pageCon.jumpToPage(value);
              }),
              elevation: 0,
              backgroundColor: kWhiteColor.withOpacity(0.8),
              selectedIndex: currentIndex,
              indicatorColor: kPrimaryColor.withOpacity(0.2),
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Home",
                  selectedIcon: Icon(
                    Icons.home,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Icons.add),
                  label: "add",
                  selectedIcon: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: "Search",
                  selectedIcon: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: "Profile",
                  selectedIcon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ));
  }
}
