
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/error_retry_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/o2o_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const O2OUsersPage(false);
      case 1:
        return const Center(
          child: Text('Group Users'),
        );
      case 2:
        return const Center(
          child: Text('Calls'),
        );
      case 3:
        return const Center(
          child: Text('Rings'),
        );
      default:
        return ErrorRetryWidget("error!", () => {
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      // body: screens[_currentIndex],
      body: _getDrawerItemWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/bottomIcons/chat_icon.svg",
                color: RingyColors.primaryColor,
              ),
              icon: SvgPicture.asset(
                "assets/bottomIcons/chat_icon.svg",
              ),
              label: StringsEn.chat),
          const BottomNavigationBarItem(
              icon: Icon(Icons.group), label: StringsEn.groups),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/bottomIcons/calls_icon.svg",
                color: RingyColors.primaryColor,
              ),
              icon: SvgPicture.asset(
                "assets/bottomIcons/calls_icon.svg",
              ),
              label: StringsEn.call),
    const BottomNavigationBarItem(
    icon: Icon(Icons.settings), label: StringsEn.settings),
          // BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/bottomIcons/ic_briefcase.png")), label: 'JOBS'),
        ],
        selectedItemColor: RingyColors.primaryColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
