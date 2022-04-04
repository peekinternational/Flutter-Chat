class Register {
  String? message;
  int? status;
  Users? users;

  Register({this.message, this.status, this.users});

  Register.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
  String? projectId;
  String? name;
  String? email;
  int? usCount;
  LatestMsgs? latestMsg;

  Users({this.projectId, this.name, this.email, this.usCount, this.latestMsg});

  Users.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    name = json['name'];
    email = json['email'];
    usCount = json['usCount'];
    latestMsg = json['latestMsg'] != null
        ? new LatestMsgs.fromJson(json['latestMsg'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['usCount'] = this.usCount;
    if (this.latestMsg != null) {
      data['latestMsg'] = this.latestMsg!.toJson();
    }
    return data;
  }
}

class LatestMsgs {
  String? message;

  LatestMsgs({this.message});

  LatestMsgs.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
