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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['encoding'] = this.encoding;
    data['mimetype'] = this.mimetype;
    data['destination'] = this.destination;
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['size'] = this.size;
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
    projectId = json['projectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['chatType'] = this.chatType;
    data['status'] = this.status;
    data['isSeen'] = this.isSeen;
    data['isDeleted'] = this.isDeleted;
    if (this.deletedBy != null) {
      data['deletedBy'] = this.deletedBy!.map((v) => v.toJson()).toList();
    }
    data['isGroup'] = this.isGroup;
    data['bookmarked'] = this.bookmarked;
    if (this.bookmarkedChat != null) {
      data['bookmarkedChat'] =
          this.bookmarkedChat!.map((v) => v.toJson()).toList();
    }
    data['receiptStatus'] = this.receiptStatus;
    data['hide'] = this.hide;
    data['_id'] = this.sId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['projectId'] = this.projectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
