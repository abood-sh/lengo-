import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lengo/screen/tabbar/profile.dart';
import 'package:lengo/screen/tabbar/ranking.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'home.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  PageController _pageController = PageController();

  int indexTap = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            Home(),
            Ranking(),
            Profile(),
          ],
          onPageChanged: (index) {
            setState(() {
              indexTap = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: indexTap == 1 ? "#F2F2F2".toHexa() : Colors.transparent,
          elevation: 0,
          onTap: (index) {
            setState(() {
              indexTap = index;
            });
            _pageController.animateToPage(indexTap,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn
            );
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset(indexTap != 0 ? Assets.shared.icHome : Assets.shared.icHomeFill), label: ""),
            BottomNavigationBarItem(icon: SvgPicture.asset(indexTap != 1 ? Assets.shared.icRanking : Assets.shared.icRankingFill), label: ""),
            BottomNavigationBarItem(icon: SvgPicture.asset(indexTap != 2 ? Assets.shared.icAccount : Assets.shared.icAccountFill), label: ""),
          ],
        ),
      ),
    );
  }
}