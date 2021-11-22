import 'package:flutter/material.dart';
import 'package:home_maintenance/home/fragments/HomeFragment.dart';
import 'package:home_maintenance/home/fragments/ProfileFragment.dart';
import 'package:home_maintenance/home/fragments/SettingsFragment.dart';
import 'package:home_maintenance/main.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: MyThemeData.lightBlue,
            size: 36
          ),
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/home.png')),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/profile.png')),
                label: 'My Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings')
          ],
        onTap: onBottomNavigationItemSelected,
      ),
      body: Container(
        child: getMainView(),
      ),
    );
  }
  Widget getMainView(){
    if(selectedIndex==0){
      return HomeFragment();
    }
    if(selectedIndex==1){
      return ProfileFragment();
    }
    else
      return SettingsFragment();
  }
  void onBottomNavigationItemSelected(int pos){
    setState(() {
      selectedIndex=pos;
    });
  }

}
