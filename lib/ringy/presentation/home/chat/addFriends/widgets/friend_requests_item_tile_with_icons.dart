import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';

class FriendRequestsItemTileWithIcons extends StatelessWidget {
  final UsersList model;

  const FriendRequestsItemTileWithIcons({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      title: Text(model.name!,
          style: const TextStyle(fontWeight: FontWeight.w400)),
      leading: ImageOrFirstCharacterUsers(
        radius: 25,
        maxRadius: 26,
        imageUrl: model.userImage!,
        name: model.name!,
        onlineStatus: model.onlineStatus!,
        showOnlineStatus: true,
      ),
      trailing: SizedBox(
        width: 100,
        child: Flexible(
          child: Row(children:
          [
            rejectButton(),
            const SizedBox(width: 10,),
            acceptButton(),
          ],),
        ),
      ),
    );
  }
}

Widget rejectButton() {
  return  CircleAvatar(
    child: const Center(child: Icon(Icons.close,color: Colors.red,)),
    backgroundColor: RingyColors.lightWhite,
  );
}

Widget acceptButton() {
  return  CircleAvatar(
    child: const Center(child: Icon(Icons.check,color: Colors.green,)),
    backgroundColor: RingyColors.lightWhite,
  );
}
