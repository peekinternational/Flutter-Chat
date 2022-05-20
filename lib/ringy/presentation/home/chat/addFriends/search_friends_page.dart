import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/cubit/search_users/search_users_cubit.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/text_form_filed_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/addFriends/widgets/friend_requests_send_item_tile.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../injections.dart';
import '../../../../domain/entities/add_friends/searched_users.dart';

class SearchFriendsPage extends StatelessWidget {
  SearchFriendsPage({Key? key}) : super(key: key);

  final TextEditingController searchedUserController = TextEditingController();
  final SearchUsersCubit searchUsersCubit = serviceLocator<SearchUsersCubit>();

  int clickedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SearchUsersCubit>(
        create: (context) => SearchUsersCubit(searchUsersCubit.repository),
        child: _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return BlocConsumer<SearchUsersCubit, SearchUsersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              TextFormFiledWidget(
                  label: StringsEn.searchUser,
                  hint: StringsEn.searchUser,
                  showSuffixIcon: true,
                  controller: searchedUserController,
                  closeSearch: () => {
                        searchedUserController.text = "",
                        BlocProvider.of<SearchUsersCubit>(context)
                            .textChangedSearchUser(
                                Prefs.getString(Prefs.myUserId)!, "")
                      },
                  onTextChanged: (ss) => {
                        BlocProvider.of<SearchUsersCubit>(context)
                            .textChangedSearchUser(
                                Prefs.getString(Prefs.myUserId)!, ss)
                      }),
              Expanded(
                child: state is SearchUsersSuccessState
                    ? _buildBody(context, state, state.users)
                    : state is SearchUsersSendingRequest
                        ? _buildBody(context, state, state.users)
                        : state is NoUsersState
                            ? const NoItemWidget(
                                StringsEn.noUserFound, Icons.person_search)
                            : state is SearchUsersLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, SearchUsersState state, List<Datum> list) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        indent: 20,
        endIndent: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        final revereIndex = list.length - 1 - index;
        return FriendRequestsSendItemTile(
          model: list[revereIndex],
          isRequestSending:
              state is SearchUsersSendingRequest && clickedIndex == revereIndex,
          sendFriendRequest: () =>
              _friendStatusPressed(context, list[revereIndex], revereIndex),
        );
      },
    );
  }

  _friendStatusPressed(BuildContext context, Datum model, int revereIndex) {
    model.friendStatus == 2
        ? VxToast.show(context, msg: StringsEn.alreadyRequested)
        : model.friendStatus == 0
            ? _sendFriendRequest(context, model, revereIndex)
            : VxToast.show(context, msg: StringsEn.alreadyFriends);
  }

  _sendFriendRequest(BuildContext context, Datum model, int revereIndex) {
    clickedIndex = revereIndex;
    BlocProvider.of<SearchUsersCubit>(context)
        .sendFriendRequest(Prefs.getString(Prefs.myUserId)!, model.id);
  }
}
