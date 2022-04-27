import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';

class UserItemAddGroupTile extends StatelessWidget {
  final UsersList model;

  const UserItemAddGroupTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.name!,
          style: const TextStyle(fontWeight: FontWeight.w400)),
      leading: ImageOrFirstCharacterUsers(
        radius: 25,
        maxRadius: 26,
        imageUrl: model.userImage!,
        name: model.name!,
        onlineStatus: model.onlineStatus!,
        showOnlineStatus: false,
        forGroupSelection: model.selectedForGroup ? true : false,
      ),
    );
  }
}
