class SocketCallStatus {
  String? status;
  String? id;
  bool? isGroup;
  bool? amISender;


  SocketCallStatus();

  SocketCallStatus.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    status = json['status'];
    isGroup = json['isGroup'];
    amISender = json['amISender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['isGroup'] = isGroup;
    data['amISender'] = amISender;
    return data;
  }
}

