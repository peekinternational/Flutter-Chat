class SocketTyping {
  String? selectFrienddata;
  String? userId;
  String? lastmsg;

  SocketTyping({this.selectFrienddata, this.userId});

  SocketTyping.fromJson(Map<dynamic, dynamic> json) {
    selectFrienddata = json['selectFrienddata'];
    userId = json['userId'];
    lastmsg = json['lastmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectFrienddata'] = selectFrienddata;
    data['userId'] = userId;
    data['lastmsg'] = lastmsg;
    return data;
  }
}

