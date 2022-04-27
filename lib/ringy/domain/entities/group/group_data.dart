class GroupData {
  String? name;
  List<String>? members;
  String? creatorUserId;
  String? projectId;
  String? groupImage;
  int? status;

  GroupData(
      {this.name,
        this.members,
        this.creatorUserId,
        this.projectId,
        this.groupImage,
        this.status});

  GroupData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    members = json['members'].cast<String>();
    creatorUserId = json['creatorUserId'];
    projectId = json['projectId'];
    status = json['status'];
    groupImage = json['group_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['members'] = members;
    data['creatorUserId'] = creatorUserId;
    data['projectId'] = projectId;
    data['status'] = status;
    data['group_image'] = groupImage;
    return data;
  }
}
