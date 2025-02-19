import 'dart:convert';

SettingResponce routeModelFromJson(String str) => SettingResponce.fromJson(json.decode(str));

String routeModelToJson(SettingResponce data) => json.encode(data.toJson());

class SettingResponce {
  String? errorCode;
  String? errorMsg;
  List<void>? data;
  List<CottonVariety>? cottonVariety;
  List<TypeFertilization>? typeFertilization;
  List<TypePesticides>? typePesticides;
  List<YarQuality>? yarQuality;
  List<Setting>? setting;

  SettingResponce(
      {this.errorCode,
        this.errorMsg,
        this.data,
        this.cottonVariety,
        this.typeFertilization,
        this.typePesticides,
        this.yarQuality,
        this.setting});

  SettingResponce.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
      });
    }
    if (json['cotton_variety'] != null) {
      cottonVariety = <CottonVariety>[];
      json['cotton_variety'].forEach((v) {
        cottonVariety!.add(CottonVariety.fromJson(v));
      });
    }
    if (json['type_fertilization'] != null) {
      typeFertilization = <TypeFertilization>[];
      json['type_fertilization'].forEach((v) {
        typeFertilization!.add(TypeFertilization.fromJson(v));
      });
    }
    if (json['type_pesticides'] != null) {
      typePesticides = <TypePesticides>[];
      json['type_pesticides'].forEach((v) {
        typePesticides!.add(TypePesticides.fromJson(v));
      });
    }
    if (json['yar_quality'] != null) {
      yarQuality = <YarQuality>[];
      json['yar_quality'].forEach((v) {
        yarQuality!.add(new YarQuality.fromJson(v));
      });
    }
    if (json['setting'] != null) {
      setting = <Setting>[];
      json['setting'].forEach((v) {
        setting!.add(Setting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    if (this.data != null) {

    }
    if (cottonVariety != null) {
      data['cotton_variety'] =
          cottonVariety!.map((v) => v.toJson()).toList();
    }
    if (typeFertilization != null) {
      data['type_fertilization'] =
          typeFertilization!.map((v) => v.toJson()).toList();
    }
    if (typePesticides != null) {
      data['type_pesticides'] =
          typePesticides!.map((v) => v.toJson()).toList();
    }
    if (this.yarQuality != null) {
      data['yar_quality'] = this.yarQuality!.map((v) => v.toJson()).toList();
    }
    if (setting != null) {
      data['setting'] = setting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CottonVariety {
  int? id;
  String? name;
  String? image;
  String? description;
  String? createdAt;
  int? status;

  CottonVariety(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.createdAt,
        this.status});

  CottonVariety.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['status'] = status;
    return data;
  }
}

class TypeFertilization {
  int? id;
  String? name;
  String? image;
  String? description;
  String? createdAt;
  int? status;

  TypeFertilization(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.createdAt,
        this.status});

  TypeFertilization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['status'] = status;
    return data;
  }
}
class TypePesticides {
  int? id;
  String? name;
  String? image;
  String? description;
  String? createdAt;
  int? status;

  TypePesticides(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.createdAt,
        this.status});

  TypePesticides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['status'] = status;
    return data;
  }
}
class YarQuality {
  int? id;
  String? name;
  String? image;
  String? description;
  String? createdAt;
  int? status;

  YarQuality(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.createdAt,
        this.status});

  YarQuality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['status'] = status;
    return data;
  }
}

class Setting {
  int? id;
  String? keyType;
  String? keyValue;

  Setting({this.id, this.keyType, this.keyValue});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyType = json['key_type'];
    keyValue = json['key_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key_type'] = keyType;
    data['key_value'] = keyValue;
    return data;
  }
}