import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/addFriends/widgets/friend_requests_item_tile_with_texts.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../../../injections.dart';
import '../../../../application/cubit/friend_requests/friend_requests_cubit.dart';
import '../../../core/widgets/center_circular_progress.dart';

class AcceptFriendsPage extends StatelessWidget {
  AcceptFriendsPage({Key? key}) : super(key: key);

  final FriendRequestsCubit searchUsersCubit =
      serviceLocator<FriendRequestsCubit>();

  int clickedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FriendRequestsCubit>(
        create: (context) {
          return FriendRequestsCubit(searchUsersCubit.repository);
        },
        child: _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return BlocConsumer<FriendRequestsCubit, FriendRequestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is FriendRequestsSuccessState
              ? _buildBody(context, state, state.users)
              : state is FriendRequestsUpdateRequest
                  ? _buildBody(context, state, state.users)
                  : state is NoUsersState
                      ? const NoItemWidget(
                          StringsEn.noFriendRequest, Icons.person_search)
                      : state is FriendRequestsLoadingState
                          ? const CenterCircularProgress()
                          : const SizedBox(),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FriendRequestsState state,
      List<FriendRequests> list) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        indent: 20,
        endIndent: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        final revereIndex = list.length - 1 - index;
        return FriendRequestsItemTileWithTexts(
          model: list[revereIndex],
          acceptRequest: () =>
              _updateRequest(context, list[revereIndex], revereIndex, 1),
          isRequestSending: state is FriendRequestsUpdateRequest &&
              clickedIndex == revereIndex,
          rejectRequest: () =>
              _updateRequest(context, list[revereIndex], revereIndex, 3),
        );
      },
    );
  }

  _updateRequest(
      BuildContext context, FriendRequests model, int revereIndex, int status) {
    clickedIndex = revereIndex;
    BlocProvider.of<FriendRequestsCubit>(context).updateFriendRequest(
        model.id, model.userId.id, model.friendId.id, status);
  }
}
