import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/group_list/group_list_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/users/groupListModel/group_list_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/user_item_tile.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../../../../injections.dart';
import '../../../../core/widgets/center_circular_progress.dart';

class GroupsListPage extends StatelessWidget {
  final bool showUsers;

  const GroupsListPage(this.showUsers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupListBloc userListBloc = serviceLocator<GroupListBloc>();
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: RingyColors.lightWhite,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: RingyColors.lightWhite,
          title: Text(
            showUsers ? StringsEn.forwardTo : StringsEn.groups,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
          ),
          actions: [
            GestureDetector(
                onTap: () =>
                    context
                        .pushRoute(const AddGroupUsersRoute()),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 12),
                  child: Icon(
                    Icons.group_add_rounded,
                    color: RingyColors.primaryColor,
                  ),
                ))
          ],
        ),
        body: BlocProvider<GroupListBloc>(
          create: (context) =>
          userListBloc
            ..add(GetGroupsEvent(Constants.projectId,
                Prefs.getString(Prefs.myUserId)!, showUsers)),
          child: BlocBuilder<GroupListBloc, GroupListState>(
            builder: (context, state) {
              if (state is LoadedState) {
                var mList = state.groups;
                mList.sort((a, b) =>
                    a.latestMsgCreatedAt.compareTo(b.latestMsgCreatedAt));
                return _buildBody(context, mList, showUsers);
              } else if (state is NoGroupsState) {
                return const NoItemWidget(
                    StringsEn.noGroupExists, Icons.group);
              } else {
                return const CenterCircularProgress();
              }
            },
          ),
        ));

  }
}

Widget _buildBody(BuildContext context, List<GroupList> list, bool showUsers) {
  return ListView.separated(
    shrinkWrap: true,
    itemCount: list.length,
    separatorBuilder: (BuildContext context, int index) =>
    const Divider(
      indent: 20,
      endIndent: 20,
    ),
    itemBuilder: (BuildContext context, int index) {
      final revereIndex = list.length - 1 - index;
      return UserItemTile(
          userModel: null, groupModel: list[revereIndex], isGroup: true);
    },
  );
}
