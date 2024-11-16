class FaceRequestModel {
  String? sendDate;
  String? hostname;
  int? userType;
  String? image;

  FaceRequestModel({this.sendDate, this.hostname, this.userType, this.image});

  FaceRequestModel.fromJson(Map<String, dynamic> json) {
    sendDate = json['sendDate'];
    hostname = json['hostname'];
    userType = json['userType'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sendDate'] = this.sendDate;
    data['hostname'] = this.hostname;
    data['userType'] = this.userType;
    data['image'] = this.image;
    return data;
  }
}
