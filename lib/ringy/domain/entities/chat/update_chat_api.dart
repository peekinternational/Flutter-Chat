class UpdateMessageDataModel {
  String? messageId;
  MsgDataUpdate? msgData;


  UpdateMessageDataModel();

  UpdateMessageDataModel.fromJson(Map<String, dynamic> json) {
    messageId = json['id'];
    msgData = json['msgData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = messageId;
    data['msgData'] = msgData;
    return data;
  }
}

class MsgDataUpdate {
  String? message;

  MsgDataUpdate();

  MsgDataUpdate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}