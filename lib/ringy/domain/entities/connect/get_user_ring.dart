import 'dart:core';
class GetUserRing
{

   String flag;
   String code;
   String message;
   List<GetUserRingModel> ringData;
   GetUserRing(this.flag, this.code, this.message, this.ringData);

   GetUserRing.fromJson(Map<String, dynamic> json):
         flag = json['flag'],
         code = json['code'],
        message = json['message'],
        ringData = json['ringData'];


   Map<String, dynamic> toJson() => {
     'flag': flag,
     'code': code,
     'message': message,
     'ringData': ringData,

   };

}
class GetUserRingModel{

  String ringId;
  String ringName;
  String ringUserId;
  String pImage;

  GetUserRingModel.fromJson(Map<String, dynamic> json):
        ringId = json['_id'],
        ringName = json['ring_name'],
        ringUserId = json['ring_user_id'],
        pImage = json['p_image'];

  Map<String, dynamic> toJson() => {
    '_id': ringId,
    'ring_name': ringName,
    'ring_user_id': ringUserId,
    'p_image': pImage,
  };
}