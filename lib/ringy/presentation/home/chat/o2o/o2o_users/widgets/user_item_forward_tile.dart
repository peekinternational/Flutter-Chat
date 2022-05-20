import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';

class UserItemForwardTile extends StatelessWidget {
  final UsersList model;

  const UserItemForwardTile({Key? key, required this.model}) : super(key: key);

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
      trailing: GestureDetector(
        onTap: () => _nextPage(context, model),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: RingyColors.lightWhite,
          ),
          child: const Icon(
            Icons.arrow_forward_rounded,
            size: 18,
          ),
        ),
      ),
    );
  }

  _nextPage(BuildContext context, UsersList model) {
    context.popRoute(model);
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
}
