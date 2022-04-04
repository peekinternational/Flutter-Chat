import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/user_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/data_travel_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../../../routes/router.dart';

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
            borderRadius: const BorderRadius.all(Radius.circular(1)),
            color: RingyColors.lightWhite,
          ),
          child: const Icon(
            Icons.send,
            size: 18,
          ),
        ),
      ),
    );
  }

  _nextPage(BuildContext context, UsersList model) {
    // TmpDataTravel tmpDataTravel = TmpDataTravel();
    // tmpDataTravel.name = model.name!;
    // tmpDataTravel.image = model.userImage!;
    // tmpDataTravel.recieverId = model.sId!;
    // tmpDataTravel.isOnlineHide = "0";
    // tmpDataTravel.isOnline = model.onlineStatus!;
    // tmpDataTravel.mainUserId = model.userId!;
    //
    // context.pushRoute(ChatScreenRoute(dataTravel: tmpDataTravel));
    context.popRoute(model);
    // Navigator.pop(context, model);
  }
}
