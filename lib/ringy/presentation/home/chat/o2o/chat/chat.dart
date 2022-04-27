import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/typing.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/infrastructure/API/dio_client.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/data_travel_model.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/error_retry_widget.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/chat/message_views_widgets/items.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart' as open;
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../injections.dart';
import 'message_views_widgets/app_bar_view.dart';
import 'message_views_widgets/chat_item_design.dart';

class ChatScreenPage extends StatelessWidget {
  final TmpDataTravel dataTravel;

  ChatScreenPage(this.dataTravel, {Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();
  final ChatListBloc chatListBloc = serviceLocator<ChatListBloc>();
  List<ChatModel> mList = [];
  final focus = FocusNode();
  String selectedMessageId = "";
  bool isEditMessage = false;
  bool isDownloading = false;
  final myID = Prefs.getString(Prefs.myUserId) ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: RingyColors.lightWhite,
          flexibleSpace: BlocProvider<ChatListBloc>(
            create: (context) => chatListBloc
              ..add(GetChatsEvent(
                  senderId: myID,
                  receiverId: dataTravel.recieverId,
                  limit: "100",
                  isGroup: dataTravel.isGroup)),
            child: AppBarChat(dataTravel),
          ),
        ),
        body: BlocProvider<ChatListBloc>(
            create: (context) => chatListBloc
              ..add(GetChatsEvent(
                  senderId: myID,
                  receiverId: dataTravel.recieverId,
                  limit: "100",
                  isGroup: dataTravel.isGroup)),
            child: BlocBuilder<ChatListBloc, ChatListState>(
                buildWhen: (previous, current) =>
                    previous != current && current is! AppBarRefreshState,
                builder: (context, ChatListState state) {
                  if (state is ChatListLoadedState) {
                    mList = state.chats;
                    return _buildBody(context, mList, chatListBloc);
                  } else if (state is ChatsLoadingState) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: RingyColors.primaryColor,
                    ));
                  } else if (state is ChatListErrorState) {
                    return ErrorRetryWidget(
                        StringsEn.errorWhileFetchingChat,
                        () => {
                              chatListBloc
                                ..add(GetChatsEvent(
                                    senderId: myID,
                                    receiverId: dataTravel.recieverId,
                                    limit: "100",
                                    isGroup: dataTravel.isGroup)),
                            });
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: RingyColors.primaryColor,
                  ));
                })));
  }

  Widget _buildBody(BuildContext context, List<ChatModel> messages,
      ChatListBloc chatListBloc) {
    return Column(
      children: [
        Expanded(
            child: messages.isNotEmpty
                ? _buildListMessage(context, messages)
                : const NoItemWidget(
                    StringsEn.noChatFound, Icons.chat_bubble_outline)),
        const Divider(height: 1),
        _buildInput(context, messages, chatListBloc),
      ],
    );
  }

  Widget _buildInput(BuildContext context, List<ChatModel> messages,
      ChatListBloc chatListBloc) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            // height: 70,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                !isEditMessage
                    ? GestureDetector(
                  onTap: () {
                    _showBottomMenu(context);
                  },
                  child: Transform.rotate(
                    angle: 45,
                    child: const Icon(
                      Icons.attach_file,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                )
                    : const SizedBox(),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(80)),
                        color: RingyColors.lightWhite,
                        border: Border.all(color: Colors.black12)),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () => {},
                            child: const Icon(
                                Icons.emoji_emotions_outlined)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            maxLines: 4,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            focusNode: focus,
                            controller: _editingController,
                            decoration: const InputDecoration(
                              hintText: StringsEn.enterMessage,
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (dataTravel.isGroup == 0) {
                                SocketTyping socketTyping =
                                SocketTyping();
                                socketTyping.userId = myID;
                                socketTyping.selectFrienddata =
                                    dataTravel.recieverId;
                                socketTyping.lastmsg =
                                    messages[messages.length - 1].message;
                                chatListBloc
                                    .add(TypingEvent(socketTyping, true));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    if (_editingController.text != "") {
                      sendSimpleChat(context, _editingController.text,
                          chatListBloc, 0, dataTravel);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(1)),
                      color: RingyColors.lightWhite,
                    ),
                    child: const Icon(
                      Icons.send,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListMessage(BuildContext context, List<ChatModel> messages) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      shrinkWrap: true,
      cacheExtent: 100,
      controller: scrollController,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemBuilder: (context, index) {
        final revereIndex = messages.length - 1 - index;
        return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => {
                  if (messages[revereIndex].isDeleted != 1 &&
                      messages[revereIndex].messageType != 0)
                    {_openFile(context, messages[revereIndex])}
                },
            onLongPress: () => {
                  if (messages[revereIndex].isDeleted != 1)
                    _showBottomMessageOptions(context, messages[revereIndex])
                },
            child: ChatItemDesign(
                messages, revereIndex, _editingController, dataTravel.isGroup));
      },
    );
  }

  void sendSimpleChat(BuildContext context, String message,
      ChatListBloc chatListBloc, int messageType, TmpDataTravel tmpDataTravel) {
    if (isEditMessage) {
      BlocProvider.of<ChatListBloc>(context).repository.updateMessage(
          HelperModels.editMessageModel(
              _editingController.text, selectedMessageId));
    } else {
      // chatListBloc.add(UpdateChatsEvent(
      //     HelperModels.sendMessageToSocketModel(tmpDataTravel, message),
      //     messages));

      if (dataTravel.isGroup == 0) {
        BlocProvider.of<ChatListBloc>(context).repository.sendMessage(
            HelperModels.sendMessageModel(tmpDataTravel, message, messageType));
      } else {
        BlocProvider.of<ChatListBloc>(context).repository.sendGroupMessage(
            tmpDataTravel.recieverId, myID, message, messageType);
      }
      if (mList.isNotEmpty) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }

      if (tmpDataTravel.recieverId == dataTravel.recieverId) {
        mList.add(HelperModels.addDummyMessageModel(message, messageType,
            tmpDataTravel.isGroup, tmpDataTravel.recieverId));
      }
      chatListBloc.add(UpdateChatsEvent(null, mList));
    }

    _editingController.clear();
    isEditMessage = false;
  }

  void _showBottomMenu(BuildContext context) {
    final items = <Widget>[
      Items(
          StringsEn.camera,
          Icons.photo_camera,
          () => {
                _getFromCamera(context),
                Navigator.pop(context),
              },
          true),
      Items(
          StringsEn.gallery,
          Icons.photo_library,
          () => {
                _getFromGallery(context),
                Navigator.pop(context),
              },
          true),
      Items(
          StringsEn.files,
          Icons.file_copy,
          () => {
                _getFile(context),
                Navigator.pop(context),
              },
          true),
      Items(
          StringsEn.videos,
          Icons.videocam_outlined,
          () => {
                _getVideo(context),
                Navigator.pop(context),
              },
          false),
    ];

    HelperModels.showActualBottom(items, context);
  }

  _getFromCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    shareFile(null, photo, null, Constants.imageMSG, context);
  }

  _getFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? photo = await _picker.pickMultiImage();
    shareFile(photo!, null, null, Constants.imageMSG, context);
    // final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
  }

  _getVideo(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    shareFile(null, video!, null, Constants.videoMSG, context);
  }

  _getFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "xlsx",
        "xls",
        "doc",
        "docx",
        "ppt",
        "pptx",
        "pdf",
        "txt"
      ],
    );

    if (result != null) {
      shareFile(null, null, result, Constants.fileMSG, context);
    }
  }

  void _showBottomMessageOptions(BuildContext context, ChatModel message) {
    final items = <Widget>[
      if (message.messageType == 0 && message.senderId!.id == myID)
        Items(
            StringsEn.edit,
            Icons.edit,
            () => {
                  Navigator.pop(context),
                  _editMessage(context, message),
                },
            true),
      Items(
          StringsEn.delete,
          Icons.delete_outline_rounded,
          () => {
                Navigator.pop(context),
                _deleteMessage(context, message),
              },
          true),
      Items(
          StringsEn.forward,
          Icons.forward_to_inbox_sharp,
          () => {
                Navigator.pop(context),
                _forwardMessage(context, message),
              },
          false),
    ];

    HelperModels.showActualBottom(items, context);
  }

  void _editMessage(BuildContext context, ChatModel message) {
    _editingController.text = message.message!;
    selectedMessageId = message.sId!;
    isEditMessage = true;
    FocusScope.of(context).requestFocus(focus);
  }

  void _deleteMessage(BuildContext context, ChatModel message) {
    BlocProvider.of<ChatListBloc>(context)
        .repository
        .deleteMessage(message.sId!, "0");
  }

  Future<void> _forwardMessage(BuildContext context, ChatModel message) async {
    final result = await context.pushRoute(O2OUsersRoute(showUsers: true));

    if (result != null) {
      UsersList? usersList = result as UsersList?;
      sendSimpleChat(
          context,
          message.message!,
          chatListBloc,
          message.messageType!,
          HelperModels.getUserListToTempDataTravel(usersList!));
    }
  }

  void shareFile(
      List<XFile>? multiFile,
      XFile? singleFile,
      FilePickerResult? filePickerResult,
      int messageType,
      BuildContext context) {
    BlocProvider.of<ChatListBloc>(context).repository.chatFileShare(
        HelperModels.chatFileShareModel(multiFile, singleFile, filePickerResult,
            dataTravel.isGroup, messageType, dataTravel.recieverId));

    String message = "";
    if (multiFile != null) {
      for (var item in multiFile) {
        message = item.name;
      }
    } else if (singleFile != null) {
      message = singleFile.name;
    } else {
      message = filePickerResult!.files.single.name;
    }

    mList.add(HelperModels.addDummyMessageModel(
        message, messageType, dataTravel.isGroup, dataTravel.recieverId));

    chatListBloc.add(UpdateChatsEvent(null, mList));
    if (mList.isNotEmpty) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  Future<void> _openFile(BuildContext context, ChatModel message) async {
    if (isDownloading) {
      VxToast.show(context, msg: StringsEn.downloadingInProgressValidation);
      return;
    }

    if (message.messageType == Constants.imageMSG ||
        message.messageType == Constants.videoMSG) {
      context.pushRoute(OpenMediaRoute(
          isVideo: message.messageType == Constants.videoMSG,
          url: message.message!));
    } else if (message.messageType == Constants.fileMSG) {
      File ff = File(await HelperClass.getFilePath(message.message!));
      if (ff.existsSync()) {
        open.OpenFile.open(ff.path);
      } else {
        isDownloading = true;
        VxToast.show(context, msg: StringsEn.downloading, showTime: 3000);
        Dio dio = DioClient.instance.getDioClient();
        await dio.download(
          APIContent.imageURl + message.message!,
          await HelperClass.getFilePath(message.message!),
          onReceiveProgress: (count, total) {
            print((count / total) * 100);
          },
        );
        isDownloading = false;
        if (ff.existsSync()) {
          open.OpenFile.open(ff.path);
        } else {
          VxToast.show(context, msg: StringsEn.downloadingFailedToast);
        }
      }
    }
  }
}
