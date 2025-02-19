class UpdateDeviceTokenResponce {
  String? errorCode;
  String? errorMsg;
  List<void>? data;

  UpdateDeviceTokenResponce({this.errorCode, this.errorMsg, this.data});

  UpdateDeviceTokenResponce.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    if (this.data != null) {

    }
    return data;
  }
}