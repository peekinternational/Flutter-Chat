import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/data_travel_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/presentation/home/call/call_out.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarChat extends StatelessWidget {
  final TmpDataTravel tmpDataTravel;

  const AppBarChat(this.tmpDataTravel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAppBarSafeArea(context, tmpDataTravel);
  }
}

Widget _buildAppBarSafeArea(BuildContext context, TmpDataTravel dataTravel) {
  var onlineText =
      dataTravel.isOnline == 1 ? StringsEn.online : StringsEn.offline;
  return SafeArea(
    child: BlocConsumer<ChatListBloc, ChatListState>(
      buildWhen: (previous, current) =>
          previous != current && current is AppBarRefreshState,
      listener: (context, state) {
        if (state is AppBarRefreshState) {
          if (state.isOnlineSocketHit) {
            dataTravel.isOnline = state.isOnline;
            onlineText =
                dataTravel.isOnline == 1 ? StringsEn.online : StringsEn.offline;
          } else {
            if (state.isTyping) {
              onlineText = StringsEn.typing;
            } else {
              onlineText = dataTravel.isOnline == 1
                  ? StringsEn.online
                  : StringsEn.offline;
            }
          }
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  context.popRoute();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Hero(
                tag: "mTag${dataTravel.name}",
                child: ImageOrFirstCharacterUsers(
                  imageUrl: dataTravel.image,
                  name: dataTravel.name,
                  onlineStatus:
                      dataTravel.isOnlineHide == "0" ? dataTravel.isOnline : 2,
                  radius: 18,
                  maxRadius: 19,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dataTravel.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (dataTravel.isOnlineHide == "0" &&
                        dataTravel.isGroup != 1)
                      Text(
                        onlineText,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => {
                  HelperModels.changeStatusColor(RingyColors.overlayCall),

                  // Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //
                  //               // CallOut(dataTravel.name,
                  //               // dataTravel.recieverId, dataTravel.image,dataTravel.fcmId),
                  //         ))
                  context.router
                      .push(CallOutRoute(
                          receiverName: dataTravel.name,
                          receiverId: dataTravel.recieverId,
                          receiverImage: dataTravel.image,
                          groupCall: dataTravel.isGroup==1,
                          fcmIdList: dataTravel.fcmId))
                      .then((value) => HelperModels.changeStatusColor(
                          RingyColors.lightWhite)),
                },
                icon: Icon(
                  Icons.call,
                  color: RingyColors.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
