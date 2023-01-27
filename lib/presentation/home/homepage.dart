import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class homepageView extends StatefulWidget {
  const homepageView({Key? key}) : super(key: key);
  @override
  _homepageViewState createState() => _homepageViewState();
}

class _homepageViewState extends State<homepageView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Home.svg",
              width: 30,
              height: 35,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Today.svg",
                  width: 30, height: 35),
              label: '일정'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/Dashboard.svg",
                width: 30,
                height: 35,
              ),
              label: "피드"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/Store.svg",
                width: 30,
                height: 35,
              ),
              label: "스토어"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
