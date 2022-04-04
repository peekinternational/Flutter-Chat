class LoginResponse {
  Data? data;
  String? imageFile;
  bool? isUserExist;

  LoginResponse({this.data, this.imageFile, this.isUserExist});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    imageFile = json['imageFile'];
    isUserExist = json['isUserExist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['imageFile'] = this.imageFile;
    data['isUserExist'] = this.isUserExist;
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? name;

  Data({this.id, this.email, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
