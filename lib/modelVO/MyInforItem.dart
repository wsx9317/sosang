// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyInfoItem {
  String? userNo;
  String? userId;
  String? userName;
  String? userEmail;
  String? userTel;
  String? userOrg;
  String? userType;
  String? grade;
  String? office;
  String? officeAddr;
  String? officeAddrDetail;
  String? regularReqDate;
  String? regularDate;
  String? ncardUrl;
  String? ncardName;
  String? signupRoute;
  String? newsPushYn;
  String? promoPushYn;
  String? promoAgreeDate;
  String? pushTkn;
  String? delYn;
  String? createDate;
  String? createId;
  String? updateDate;
  String? updateId;
  String? regularRegYn;
  String? s3FileUrl;
  String? accessToken;

  MyInfoItem(
      {this.userNo,
      this.userId,
      this.userName,
      this.userEmail,
      this.userTel,
      this.userOrg,
      this.userType,
      this.grade,
      this.office,
      this.officeAddr,
      this.officeAddrDetail,
      this.regularReqDate,
      this.regularDate,
      this.ncardUrl,
      this.ncardName,
      this.signupRoute,
      this.newsPushYn,
      this.promoPushYn,
      this.promoAgreeDate,
      this.pushTkn,
      this.delYn,
      this.createDate,
      this.createId,
      this.updateDate,
      this.updateId,
      this.regularRegYn,
      this.s3FileUrl,
      this.accessToken});

  MyInfoItem.fromJson(Map<String, dynamic> json)
      : userNo = json['userNo'] as String?,
        userId = json['userId'] as String?,
        userName = json['userName'] as String?,
        userEmail = json['userEmail'] as String?,
        userTel = json['userTel'] as String?,
        userOrg = json['userOrg'] as String?,
        userType = json['userType'] as String?,
        grade = json['grade'] as String?,
        office = json['office'] as String?,
        officeAddr = json['officeAddr'] as String?,
        officeAddrDetail = json['officeAddrDetail'] as String?,
        regularReqDate = json['regularReqDate'] as String?,
        regularDate = json['regularDate'] as String?,
        ncardUrl = json['ncardUrl'] as String?,
        ncardName = json['ncardName'] as String?,
        signupRoute = json['signupRoute'] as String?,
        newsPushYn = json['newsPushYn'] as String?,
        promoPushYn = json['promoPushYn'] as String?,
        promoAgreeDate = json['promoAgreeDate'] as String?,
        pushTkn = json['pushTkn'] as String?,
        delYn = json['delYn'] as String?,
        createDate = json['createDate'] as String?,
        createId = json['createId'] as String?,
        updateDate = json['updateDate'] as String?,
        updateId = json['updateId'] as String?,
        regularRegYn = json['regularRegYn'] as String?,
        s3FileUrl = json['s3FileUrl'] as String?,
        accessToken = json['accessToken'] as String?;

  Map<String, dynamic> toJson() => {
        'userNo': userNo,
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'userTel': userTel,
        'userOrg': userOrg,
        'userType': userType,
        'grade': grade,
        'office': office,
        'officeAddr': officeAddr,
        'officeAddrDetail': officeAddrDetail,
        'regularReqDate': regularReqDate,
        'regularDate': regularDate,
        'ncardUrl': ncardUrl,
        'ncardName': ncardName,
        'signupRoute': signupRoute,
        'newsPushYn': newsPushYn,
        'promoPushYn': promoPushYn,
        'promoAgreeDate': promoAgreeDate,
        'pushTkn': pushTkn,
        'delYn': delYn,
        'createDate': createDate,
        'createId': createId,
        'updateDate': updateDate,
        'updateId': updateId,
        'regularRegYn': regularRegYn,
        's3FileUrl': s3FileUrl,
        'accessToken': accessToken,
      };

  bool isEmpty() {
    return userNo == null;
  }

  bool isNotEmpty() {
    return userNo != null;
  }

  @override
  String toString() {
    return 'MyInfoItem(userNo: $userNo, userId: $userId, userName: $userName, userEmail: $userEmail, userTel: $userTel, userOrg: $userOrg, userType: $userType, grade: $grade, office: $office, officeAddr: $officeAddr, officeAddrDetail:$officeAddrDetail, regularReqDate: $regularReqDate, regularDate: $regularDate, ncardUrl: $ncardUrl, ncardName: $ncardName, signupRoute: $signupRoute, newsPushYn: $newsPushYn, promoPushYn: $promoPushYn, promoAgreeDate: $promoAgreeDate, pushTkn: $pushTkn, delYn: $delYn, createDate: $createDate, createId: $createId, updateDate: $updateDate, updateId: $updateId, regularRegYn: $regularRegYn, s3FileUrl: $s3FileUrl, accessToken: $accessToken)';
  }
}
