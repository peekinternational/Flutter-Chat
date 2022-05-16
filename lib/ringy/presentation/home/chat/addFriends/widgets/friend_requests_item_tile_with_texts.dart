import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class FriendRequestsItemTileWithTexts extends StatelessWidget {
  final UsersList model;

  const FriendRequestsItemTileWithTexts({Key? key, required this.model})
      : super(key: key);

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
                imageUrl: model.userImage!,
                name: model.name!,
                onlineStatus: model.onlineStatus!,
                showOnlineStatus: false,
              ),
            ),
            const VerticalDivider(),
            RightBody(model)
          ],
        ),
      ),
    );
  }
}

class RightBody extends StatelessWidget {
  final UsersList model;

  const RightBody(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.name!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: acceptButton()),
              const SizedBox(width: 10,),
              Expanded(child: rejectButton()),
            ],
          ),
        )
      ],
    ));
  }
}

Widget rejectButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          StringsEn.decline,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(RingyColors.lightWhite),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        )),
  );
}

Widget acceptButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          StringsEn.confirm,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(RingyColors.primaryColor),
        )),
  );
}
