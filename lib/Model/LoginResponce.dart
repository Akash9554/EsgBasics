class LoginResponce {
  String? errorCode;
  String? errorMsg;
  List<Data>? data;

  LoginResponce({this.errorCode, this.errorMsg, this.data});

  LoginResponce.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userType;
  String? name;
  String? image;
  String? email;
  String? mobileNo;
  String? deviceType;
  String? deviceToken;
  String? otp;
  String? createdAt;
  String? profile_qr_code;

  Data(
      {this.id,
        this.userType,
        this.name,
        this.image,
        this.email,
        this.mobileNo,
        this.deviceType,
        this.deviceToken,
        this.otp,
        this.createdAt,
      this.profile_qr_code});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    otp = json['otp'];
    createdAt = json['created_at'];
    profile_qr_code=json['profile_qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['otp'] = otp;
    data['created_at'] = createdAt;
    data['profile_qr_code']=profile_qr_code;
    return data;
  }
}