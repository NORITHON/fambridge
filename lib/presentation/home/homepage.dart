import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);
  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //int _selectedIndex = 0;
      ScrollController homeController = ScrollController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Home.svg"), label: '홈'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Today.svg"), label: '일정'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Dashboard.svg"),
              label: "피드"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/.svg"), label: "스토어"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
