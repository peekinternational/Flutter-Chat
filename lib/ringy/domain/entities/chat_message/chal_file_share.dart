import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatFileShareModel {

  String? senderId, friendId, projectId  ;
  int? isFromMobile = 1,receiptStatus = 1,isGroup,messageType;
  List<XFile>? multipleFiles;
  XFile? singleFile;
  FilePickerResult? documentFile;

  ChatFileShareModel();

  ChatFileShareModel.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    senderId = json['senderId'];
    friendId = json['friendId'];
    multipleFiles = json['multipleFiles'];
    singleFile = json['singleFile'];
    documentFile = json['documentFile'];
    receiptStatus = json['receiptStatus'];
    isFromMobile = json['isFromMobile'];
    isGroup = json['isGroup'];
    messageType = json['messageType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['senderId'] = senderId;
    data['multipleFiles'] = multipleFiles;
    data['singleFile'] = singleFile;
    data['documentFile'] = documentFile;
    data['friendId'] = friendId;
    data['receiptStatus'] = receiptStatus;
    data['isFromMobile'] = isFromMobile;
    data['isGroup'] = isGroup;
    data['messageType'] = messageType;
    return data;
  }
}
