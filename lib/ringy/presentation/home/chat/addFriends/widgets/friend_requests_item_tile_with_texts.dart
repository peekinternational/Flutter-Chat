import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class FriendRequestsItemTileWithTexts extends StatelessWidget {
  final FriendRequests model;
  final bool isRequestSending;
  final VoidCallback acceptRequest;
  final VoidCallback rejectRequest;

  const FriendRequestsItemTileWithTexts({
    Key? key,
    required this.model,
    required this.isRequestSending,
    required this.acceptRequest,
    required this.rejectRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageOrFirstCharacterUsers(
                radius: 25,
                maxRadius: 26,
                imageUrl: model.userId.userImage,
                name: model.userId.name,
                onlineStatus: model.userId.onlineStatus,
                showOnlineStatus: false,
              ),
            ),
            const VerticalDivider(),
            RightBody(model, acceptRequest, rejectRequest)
          ],
        ),
      ),
    );
  }
}

class RightBody extends StatelessWidget {
  final FriendRequests model;
  final VoidCallback acceptRequest;
  final VoidCallback rejectRequest;

  const RightBody(this.model, this.acceptRequest, this.rejectRequest,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.userId.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: acceptButton(acceptRequest)),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: rejectButton(rejectRequest)),
            ],
          ),
        )
      ],
    ));
  }
}

Widget rejectButton(VoidCallback rejectRequest) {
  return InkWell(
    onTap: rejectRequest,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: RingyColors.lightWhite,
              boxShadow: const [
                BoxShadow(
                  color: Colors.red,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ]),
          child: const Center(
            child: Text(
              StringsEn.decline,
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
            ),
          )),
    ),
  );
}

Widget acceptButton(VoidCallback acceptRequest) {
  return InkWell(
    onTap: acceptRequest,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: RingyColors.lightWhite,
              boxShadow: [
                BoxShadow(
                  color: RingyColors.primaryColor,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ]),
          child: Center(
            child: Text(
              StringsEn.confirm,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: RingyColors.primaryColor),
            ),
          )),
    ),
  );
}
