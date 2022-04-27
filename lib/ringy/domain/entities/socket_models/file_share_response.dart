class FileShareResponse {
  List<File>? file;
  Data? data;

  FileShareResponse({this.file, this.data});

  FileShareResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(new File.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (file != null) {
      data['file'] = file!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class File {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  String? destination;
  String? filename;
  String? path;
  int? size;

  File(
      {this.fieldname,
        this.originalname,
        this.encoding,
        this.mimetype,
        this.destination,
        this.filename,
        this.path,
        this.size});

  File.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    destination = json['destination'];
    filename = json['filename'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldname'] = fieldname;
    data['originalname'] = originalname;
    data['encoding'] = encoding;
    data['mimetype'] = mimetype;
    data['destination'] = destination;
    data['filename'] = filename;
    data['path'] = path;
    data['size'] = size;
    return data;
  }
}

class Data {
  String? message;
  int? messageType;
  int? chatType;
  int? status;
  int? isSeen;
  int? isDeleted;
  List? deletedBy;
  int? isGroup;
  int? bookmarked;
  List? bookmarkedChat;
  int? receiptStatus;
  int? hide;
  String? sId;
  String? senderId;
  String? receiverId;
  String? groupId;
  String? projectId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.message,
        this.messageType,
        this.chatType,
        this.status,
        this.isSeen,
        this.isDeleted,
        this.deletedBy,
        this.isGroup,
        this.bookmarked,
        this.bookmarkedChat,
        this.receiptStatus,
        this.hide,
        this.sId,
        this.senderId,
        this.receiverId,
        this.groupId,
        this.projectId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageType = json['messageType'];
    chatType = json['chatType'];
    status = json['status'];
    isSeen = json['isSeen'];
    isDeleted = json['isDeleted'];
    if (json['deletedBy'] != null) {
      deletedBy = [];
      json['deletedBy'].forEach((v) {
        deletedBy!.add(v);
      });
    }
    isGroup = json['isGroup'];
    bookmarked = json['bookmarked'];
    if (json['bookmarkedChat'] != null) {
      bookmarkedChat = [];
      json['bookmarkedChat'].forEach((v) {
        bookmarkedChat!.add(v);
      });
    }
    receiptStatus = json['receiptStatus'];
    hide = json['hide'];
    sId = json['_id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    groupId = json['groupId'];
    projectId = json['projectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['messageType'] = messageType;
    data['chatType'] = chatType;
    data['status'] = status;
    data['isSeen'] = isSeen;
    data['isDeleted'] = isDeleted;
    if (deletedBy != null) {
      data['deletedBy'] = deletedBy!.map((v) => v.toJson()).toList();
    }
    data['isGroup'] = isGroup;
    data['bookmarked'] = bookmarked;
    if (bookmarkedChat != null) {
      data['bookmarkedChat'] =
          bookmarkedChat!.map((v) => v.toJson()).toList();
    }
    data['receiptStatus'] = receiptStatus;
    data['hide'] = hide;
    data['_id'] = sId;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['groupId'] = groupId;
    data['projectId'] = projectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
