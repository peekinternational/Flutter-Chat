import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/generated/assets.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/searched_users.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class FriendRequestsSendItemTile extends StatelessWidget {
  final Datum model;
  final bool isRequestSending;
  final VoidCallback sendFriendRequest;

   FriendRequestsSendItemTile(
      {Key? key,
      required this.model,
      required this.sendFriendRequest,
      required this.isRequestSending})
      : super(key: key);

  Size size = const Size(14, 14);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      title:
          Text(model.name, style: const TextStyle(fontWeight: FontWeight.w400)),
      leading: ImageOrFirstCharacterUsers(
        radius: 25,
        maxRadius: 26,
        imageUrl: model.userImage,
        name: model.name,
        onlineStatus: 0,
        showOnlineStatus: false,
      ),
      trailing: GestureDetector(
        onTap: sendFriendRequest,
        child: model.friendStatus != 1
            ? Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  color: RingyColors.lightWhite,
                  boxShadow:   const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ]
                ),
                child: isRequestSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2,))
                    : model.friendStatus == 2
                        ? SvgPicture.asset(
                            "assets/images/user_check.svg",
                            width: 14,
                            height: 14,
                            color: RingyColors.primaryColor,
                          )
                        : Icon(
                            Icons.person_add_alt_1,
                            size: 18,
                            color: RingyColors.primaryColor,
                          ),
              )
            : const SizedBox(),
      ),
    );
  }
}
