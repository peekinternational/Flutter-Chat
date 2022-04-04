class SocketEditMessage {
  String? id;
  String? projectId;
  MsgDataEdit? msgDataEdits;


  SocketEditMessage();

  SocketEditMessage.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    msgDataEdits = json['msgData'] != null ? MsgDataEdit.fromJson(json['msgData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['projectId'] = projectId;
    if (msgDataEdits != null) {
      data['msgData'] = msgDataEdits!.toJson();
    }
    return data;
  }
}

class MsgDataEdit {
  String? message;
  String? chatid;


  MsgDataEdit();

  MsgDataEdit.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    chatid = json['chatid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['chatid'] = chatid;
    return data;
  }
}

