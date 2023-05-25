import 'package:fambridge/presentation/component/bar/bottom_nav.dart';
import 'package:fambridge/presentation/pages/answerList/answer_list_view.dart';
import 'package:fambridge/presentation/pages/home/home_view.dart';
import 'package:fambridge/presentation/pages/store_details/store_view.dart';
import 'package:flutter/material.dart';

class BuildPages extends StatefulWidget {
  @override
  _BuildPagesState createState() => _BuildPagesState();
}

class _BuildPagesState extends State<BuildPages> {
  int _selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeView(),
        AnswerListView(),
        StoreView(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: CustomBottomNavbar(
        selectedIndex: _selectedIndex,
        bottomTapped: bottomTapped,
      ),
    );
  }
}
