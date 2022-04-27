import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/users/groupListModel/group_list_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/data_travel_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../../../routes/router.dart';

class UserItemTile extends StatelessWidget {
  final bool isGroup;
  final UsersList? userModel;
  final GroupList? groupModel;

  const UserItemTile(
      {Key? key,
      required this.userModel,
      required this.groupModel,
      required this.isGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usCount = isGroup ? 0 : userModel?.usCount;

    var id = isGroup ? groupModel?.sId! : userModel?.sId!;
    var userId = isGroup ? "" : userModel?.userId ?? "";
    var title = isGroup ? groupModel?.name! : userModel?.name!;
    var message = isGroup ? groupModel?.latestMsg : userModel?.latestMsg;
    var latestMsgType =
        isGroup ? groupModel?.latestMsgType : userModel?.latestMsgType;
    var latestMsgSenderId =
        isGroup ? groupModel?.latestMsgSenderId : userModel?.latestMsgSenderId;
    var image = isGroup ? groupModel?.image ?? "" : userModel?.userImage;
    var onlineStatus = isGroup ? 2 : userModel?.onlineStatus;
    var latestMsgCreatedAt = isGroup
        ? groupModel?.latestMsgCreatedAt
        : userModel?.latestMsgCreatedAt;
    var groupInInt = isGroup ? 1 : 0;
    var usCountForRead = usCount != 0;
    return InkWell(
      onTap: () => {
        nextPage(
            context, title!, image!, id!, onlineStatus!, userId, groupInInt),
      },
      child: ListTile(
        horizontalTitleGap: 10,
        title:
            Text(title!, style:  TextStyle(fontWeight: usCountForRead? FontWeight.w600 : FontWeight.w400)),
        subtitle: Text(
          HelperClass.checkLastMessage(
              message ?? "", latestMsgType ?? 0, latestMsgSenderId ?? ""),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: usCountForRead? RingyColors.primaryColor: Colors.black38),
        ),
        leading: ImageOrFirstCharacterUsers(
          radius: 25,
          maxRadius: 26,
          imageUrl: image!,
          name: title,
          onlineStatus: onlineStatus!,
          showOnlineStatus: isGroup ? false : true,
        ),
        trailing: Text(message == ""
            ? ""
            : HelperClass.getFormatedDate(latestMsgCreatedAt)),
      ),
    );
  }

  nextPage(BuildContext context, String title, String image, String id,
      int onlineStatus, String userId, int isGroup) {
    TmpDataTravel tmpDataTravel = TmpDataTravel();
    tmpDataTravel.name = title;
    tmpDataTravel.image = image;
    tmpDataTravel.recieverId = id;
    tmpDataTravel.isOnlineHide = "0";
    tmpDataTravel.isOnline = onlineStatus;
    tmpDataTravel.mainUserId = userId;
    tmpDataTravel.isGroup = isGroup;

    context.pushRoute(ChatScreenRoute(dataTravel: tmpDataTravel));
  }
}
