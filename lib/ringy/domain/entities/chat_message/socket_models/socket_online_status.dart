class SocketOnlineStatus {
  String? userId;
  int? status;


  SocketOnlineStatus(this.userId, this.status);

  SocketOnlineStatus.fromJson(Map<dynamic, dynamic> json) {

    userId = json['userId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['status'] = status;
    return data;
  }
}

