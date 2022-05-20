import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/addFriends/accept_friends_page.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/addFriends/search_friends_page.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/cubit/switch_friend_request_screens/friend_pages_cubit.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/constants.dart';

class SwitchFriendPage extends StatelessWidget {
  SwitchFriendPage({Key? key}) : super(key: key);

  final selectedColor = RingyColors.primaryColor;
  final unSelectedColor = RingyColors.unSelectedColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendPagesCubit>(
      create: (context) => FriendPagesCubit(0),
      child: _buildScaffold(context),
    );
  }

  _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return   AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: RingyColors.lightWhite,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: RingyColors.lightWhite,
      title: Text(
        StringsEn.searchUser,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: Container(
            color: RingyColors.lightWhite,
            padding: const EdgeInsets.all(14),
            height: 75,
            child: Row(
              children: [
                _buildConnectView("assets/images/connect_friend_icon.svg",
                    StringsEn.searchUser, 0),
                const VerticalDivider(thickness: 0.7),
                _buildConnectView(
                    "assets/images/friends_icon.svg", StringsEn.friendRequests, 1)
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        BlocBuilder<FriendPagesCubit, FriendPagesInitial>(
          builder: (context, state) {
            return Expanded(
                child: state.pageValue == Constants.searchFriendPage
                    ? SearchFriendsPage()
                    : AcceptFriendsPage());
          },
        )
      ],
    );
  }

  Widget _buildConnectView(String imgUrl, String title, int position) {
    return BlocBuilder<FriendPagesCubit, FriendPagesInitial>(
      builder: (context, state) {
        return Column(
          children: [
            InkWell(
              onTap: () => {
                BlocProvider.of<FriendPagesCubit>(context).changePage(position)
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    imgUrl,
                    width: 24,
                    height: 24,
                    color: position == state.pageValue
                        ? selectedColor
                        : unSelectedColor,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: position == state.pageValue
                            ? selectedColor
                            : unSelectedColor),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
