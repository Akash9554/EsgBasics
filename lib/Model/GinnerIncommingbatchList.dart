import 'dart:convert';

GinnerIncommingbatchList formrouteModelFromJsonsas(String str) => GinnerIncommingbatchList.fromJson(json.decode(str));

String formrouteModelToJsonss(GinnerIncommingbatchList data) => json.encode(data.toJson());

class GinnerIncommingbatchList {

  String? errorCode;
  String? errorMsg;
  List<GinnerIncommingList>? data;

  GinnerIncommingbatchList({this.errorCode, this.errorMsg, this.data});

  GinnerIncommingbatchList.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <GinnerIncommingList>[];
      json['data'].forEach((v) {
        data!.add(GinnerIncommingList.fromJson(v));
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

class GinnerIncommingList {
  int? id;
  int? farmerId;
  int? ginnerId;
  String? plantingDate;
  int? cottonVarietyId;
  String? expectedYield;
  int? typeFertilizationId;
  String? fertilizationAmount;
  String? wateringSchedules;
  int? typePesticidesId;
  dynamic pesticidesAmount;
  dynamic unit_price;
  String? harvesting;
  String? video;
  int? status;
  String? reply;
  String? createdAt;
  dynamic location;
  dynamic rainFedOnly;
  FarmerDetail? farmerDetail;
  GinnerInvoice? ginnerInvoice;
  FarmerDetail? ginnerDetail;
  GinnerInvoiceSpinner? ginnerInvoiceSpinner;
  FarmerDetail? spinnerDetail;
  SpinnerInvoice? spinnerInvoice;
  FarmerFormSpinnerForm? farmerFormSpinnerForm;
  FarmerDetail? textileManufacturerDetail;
  TextileInvoice? textileInvoice;
  FarmerFormTextileForm? farmerFormTextileForm;
  dynamic garmentInvoice;
  dynamic farmerFormGarmentForm;
  dynamic farmer_form_invoice_qr_code;

  GinnerIncommingList(
      {this.id,
        this.farmerId,
        this.ginnerId,
        this.plantingDate,
        this.cottonVarietyId,
        this.expectedYield,
        this.unit_price,
        this.typeFertilizationId,
        this.fertilizationAmount,
        this.wateringSchedules,
        this.typePesticidesId,
        this.pesticidesAmount,
        this.harvesting,
        this.video,
        this.status,
        this.reply,
        this.createdAt,
        this.location,
        this.rainFedOnly,
        this.farmerDetail,
        this.ginnerInvoice,
        this.ginnerDetail,
        this.ginnerInvoiceSpinner,
        this.spinnerDetail,
        this.farmer_form_invoice_qr_code,
        this.spinnerInvoice,
        this.farmerFormSpinnerForm,
        this.textileManufacturerDetail,
        this.textileInvoice,
        this.farmerFormTextileForm,
        this.garmentInvoice,
        this.farmerFormGarmentForm});

  GinnerIncommingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    ginnerId = json['ginner_id'];
    plantingDate = json['planting_date'];
    cottonVarietyId = json['cotton_variety_id'];
    expectedYield = json['expected_yield'];
    unit_price=json['unit_price'];
    typeFertilizationId = json['type_fertilization_id'];
    fertilizationAmount = json['fertilization_amount'];
    wateringSchedules = json['watering_schedules'];
    typePesticidesId = json['type_pesticides_id'];
    pesticidesAmount = json['pesticides_amount'];
    harvesting = json['harvesting'];
    farmer_form_invoice_qr_code=json['farmer_form_invoice_qr_code'];
    video = json['video'];
    status = json['status'];
    reply = json['reply'];
    createdAt = json['created_at'];
    location = json['location'];
    rainFedOnly = json['rain_fed_only'];
    farmerDetail = json['farmer_detail'] != null && json['farmer_detail'] is Map<String, dynamic>
        ? FarmerDetail.fromJson(json['farmer_detail'])
        : null;
    ginnerInvoice = json['ginner_invoice'] != null && json['ginner_invoice'] is Map<String, dynamic>
        ? GinnerInvoice.fromJson(json['ginner_invoice'])
        : null;
    ginnerDetail = json['ginner_detail'] != null && json['ginner_detail'] is Map<String, dynamic>
        ? FarmerDetail.fromJson(json['ginner_detail'])
        : null;
    ginnerInvoiceSpinner = json['ginner_invoice_spinner'] != null && json['ginner_invoice_spinner'] is Map<String, dynamic>
        ? GinnerInvoiceSpinner.fromJson(json['ginner_invoice_spinner'])
        : null;
    spinnerDetail = json['spinner_detail'] != null && json['spinner_detail'] is Map<String, dynamic>
        ? FarmerDetail.fromJson(json['spinner_detail'])
        : null;
    spinnerInvoice = json['spinner_invoice'] != null && json['spinner_invoice'] is Map<String, dynamic>
        ? SpinnerInvoice.fromJson(json['spinner_invoice'])
        : null;
    farmerFormSpinnerForm = json['farmer_form_spinner_form'] != null && json['farmer_form_spinner_form'] is Map<String, dynamic>
        ? FarmerFormSpinnerForm.fromJson(json['farmer_form_spinner_form'])
        : null;
    textileManufacturerDetail = json['textile_manufacturer_detail'] != null && json['textile_manufacturer_detail'] is Map<String, dynamic>
        ? FarmerDetail.fromJson(json['textile_manufacturer_detail'])
        : null;
    textileInvoice = json['textile_invoice'] != null && json['textile_invoice'] is Map<String, dynamic>
        ? new TextileInvoice.fromJson(json['textile_invoice'])
        : null;
    farmerFormTextileForm = json['farmer_form_textile_form'] != null && json['farmer_form_textile_form'] is Map<String, dynamic>
        ? new FarmerFormTextileForm.fromJson(json['farmer_form_textile_form'])
        : null;
    garmentInvoice = json['garment_invoice'];
    farmerFormGarmentForm = json['farmer_form_garment_form'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['ginner_id'] = ginnerId;
    data['unit_price']=unit_price;
    data['farmer_form_invoice_qr_code']=farmer_form_invoice_qr_code;
    data['planting_date'] = plantingDate;
    data['cotton_variety_id'] = cottonVarietyId;
    data['expected_yield'] = expectedYield;
    data['type_fertilization_id'] = typeFertilizationId;
    data['fertilization_amount'] = fertilizationAmount;
    data['watering_schedules'] = wateringSchedules;
    data['type_pesticides_id'] = typePesticidesId;
    data['pesticides_amount'] = pesticidesAmount;
    data['harvesting'] = harvesting;
    data['video'] = video;
    data['status'] = status;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['location'] = location;
    data['rain_fed_only'] = rainFedOnly;
    if (farmerDetail != null) {
      data['farmer_detail'] = farmerDetail!.toJson();
    }
    if (ginnerInvoice != null) {
      data['ginner_invoice'] = ginnerInvoice!.toJson();
    }
    if (ginnerDetail != null) {
      data['ginner_detail'] = ginnerDetail!.toJson();
    }
    if (ginnerInvoiceSpinner != null) {
      data['ginner_invoice_spinner'] = ginnerInvoiceSpinner!.toJson();
    }

    if (spinnerDetail != null) {
      data['spinner_detail'] = spinnerDetail!.toJson();
    }
    if (spinnerInvoice != null) {
      data['spinner_invoice'] = spinnerInvoice!.toJson();
    }
    if (this.farmerFormSpinnerForm != null) {
      data['farmer_form_spinner_form'] = this.farmerFormSpinnerForm!.toJson();
    }
    if (this.textileManufacturerDetail != null) {
      data['textile_manufacturer_detail'] =
          this.textileManufacturerDetail!.toJson();
    }
    if (this.textileInvoice != null) {
      data['textile_invoice'] = this.textileInvoice!.toJson();
    }
    if (this.farmerFormTextileForm != null) {
      data['farmer_form_textile_form'] = this.farmerFormTextileForm!.toJson();
    }
    data['garment_invoice'] = this.garmentInvoice;
    data['farmer_form_garment_form'] = this.farmerFormGarmentForm;
    return data;
  }
}

class FarmerDetail {
  int? id;
  int? userType;
  String? name;
  String? image;
  String? email;
  String? mobileNo;
  String? deviceType;
  String? deviceToken;
  dynamic otp;
  String? createdAt;

  FarmerDetail(
      {this.id,
        this.userType,
        this.name,
        this.image,
        this.email,
        this.mobileNo,
        this.deviceType,
        this.deviceToken,
        this.otp,
        this.createdAt});

  FarmerDetail.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
class GinnerInvoice {
  int? id;
  int? farmerFormId;
  int? ginnerId;
  String? qty;
  String? price;
  String? totalPrice;
  String? createdAt;
  int? farmerStatus;
  dynamic image;
  int? adminStatus;

  GinnerInvoice({this.id,
    this.farmerFormId,
    this.ginnerId,
    this.qty,
    this.image,
    this.price,
    this.totalPrice,
    this.createdAt,
    this.farmerStatus,
    this.adminStatus});

  GinnerInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    ginnerId = json['ginner_id'];
    qty = json['qty'];
    price = json['price'];
    image=json['image'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    farmerStatus = json['farmer_status'];
    adminStatus = json['admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_form_id'] = farmerFormId;
    data['ginner_id'] = ginnerId;
    data['qty'] = qty;
    data['price'] = price;
    data['image']=image;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['farmer_status'] = farmerStatus;
    data['admin_status'] = adminStatus;
    return data;
  }
}

class GinnerInvoiceSpinner {
  int? id;
  int? farmerFormId;
  int? ginnerId;
  int? spinnerId;
  String? location;
  String? dateGinning;
  String? grade;
  String? stapleLength;
  String? strength;
  String? quantityAfterGinning;
  String? createdAt;
  dynamic adminStatus;
  dynamic unit_price;
  dynamic adminReply;

  GinnerInvoiceSpinner(
      {this.id,
        this.farmerFormId,
        this.ginnerId,
        this.spinnerId,
        this.location,
        this.dateGinning,
        this.grade,
        this.stapleLength,
        this.strength,
        this.quantityAfterGinning,
        this.createdAt,
        this.unit_price,
        this.adminStatus,
        this.adminReply});

  GinnerInvoiceSpinner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    ginnerId = json['ginner_id'];
    spinnerId = json['spinner_id'];
    location = json['location'];
    dateGinning = json['date_ginning'];
    grade = json['grade'];
    stapleLength = json['staple_length'];
    strength = json['strength'];
    quantityAfterGinning = json['quantity_after_ginning'];
    createdAt = json['created_at'];
    unit_price=json['unit_price'];
    adminStatus = json['admin_status'];
    adminReply = json['admin_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_form_id'] = farmerFormId;
    data['ginner_id'] = ginnerId;
    data['spinner_id'] = spinnerId;
    data['location'] = location;
    data['date_ginning'] = dateGinning;
    data['grade'] = grade;
    data['staple_length'] = stapleLength;
    data['strength'] = strength;
    data['unit_price']=unit_price;
    data['quantity_after_ginning'] = quantityAfterGinning;
    data['created_at'] = createdAt;
    data['admin_status'] = adminStatus;
    data['admin_reply'] = adminReply;
    return data;
  }
}

class SpinnerInvoice {
  int? id;
  int? farmerFormId;
  int? spinnerId;
  String? qty;
  String? price;
  String? totalPrice;
  String? createdAt;
  int? ginnerStatus;
  int? adminStatus;

  SpinnerInvoice(
      {this.id,
        this.farmerFormId,
        this.spinnerId,
        this.qty,
        this.price,
        this.totalPrice,
        this.createdAt,
        this.ginnerStatus,
        this.adminStatus});

  SpinnerInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    spinnerId = json['spinner_id'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    ginnerStatus = json['ginner_status'];
    adminStatus = json['admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_form_id'] = farmerFormId;
    data['spinner_id'] = spinnerId;
    data['qty'] = qty;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['ginner_status'] = ginnerStatus;
    data['admin_status'] = adminStatus;
    return data;
  }
}

class FarmerFormSpinnerForm {
  int? id;
  int? farmerFormId;
  int? spinnerId;
  int? textileManufacturerId;
  String? name;
  String? location;
  String? dateSpinning;
  String? yarQualityId;
  String? count;
  String? strength;
  String? quantityYarnProduce;
  String? createdAt;
  int? adminStatus;
  dynamic adminReply;

  FarmerFormSpinnerForm(
      {this.id,
        this.farmerFormId,
        this.spinnerId,
        this.textileManufacturerId,
        this.name,
        this.location,
        this.dateSpinning,
        this.yarQualityId,
        this.count,
        this.strength,
        this.quantityYarnProduce,
        this.createdAt,
        this.adminStatus,
        this.adminReply});

  FarmerFormSpinnerForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    spinnerId = json['spinner_id'];
    textileManufacturerId = json['textile_manufacturer_id'];
    name = json['name'];
    location = json['location'];
    dateSpinning = json['date_spinning'];
    yarQualityId = json['yar_quality_id'];
    count = json['count'];
    strength = json['strength'];
    quantityYarnProduce = json['quantity_yarn_produce'];
    createdAt = json['created_at'];
    adminStatus = json['admin_status'];
    adminReply = json['admin_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['spinner_id'] = this.spinnerId;
    data['textile_manufacturer_id'] = this.textileManufacturerId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['date_spinning'] = this.dateSpinning;
    data['yar_quality_id'] = this.yarQualityId;
    data['count'] = this.count;
    data['strength'] = this.strength;
    data['quantity_yarn_produce'] = this.quantityYarnProduce;
    data['created_at'] = this.createdAt;
    data['admin_status'] = this.adminStatus;
    data['admin_reply'] = this.adminReply;
    return data;
  }
}

class TextileInvoice {
  int? id;
  int? farmerFormId;
  int? textileManufacturerId;
  String? qty;
  String? price;
  String? totalPrice;
  String? createdAt;
  int? spinnerStatus;
  int? adminStatus;

  TextileInvoice(
      {this.id,
        this.farmerFormId,
        this.textileManufacturerId,
        this.qty,
        this.price,
        this.totalPrice,
        this.createdAt,
        this.spinnerStatus,
        this.adminStatus});

  TextileInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    textileManufacturerId = json['textile_manufacturer_id'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    spinnerStatus = json['spinner_status'];
    adminStatus = json['admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['textile_manufacturer_id'] = this.textileManufacturerId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['spinner_status'] = this.spinnerStatus;
    data['admin_status'] = this.adminStatus;
    return data;
  }
}

class FarmerFormTextileForm {
  int? id;
  int? farmerFormId;
  int? textileManufacturerId;
  int? garmentManufacturerId;
  String? fabricMethod;
  String? fabricProductionDate;
  String? typesFabric;
  String? dyeingMethod;
  String? dyeingChemical;
  String? dyeingDate;
  String? qualityWeight;
  String? qualityWidth;
  String? qualityColor;
  String? qualityShrinkage;
  String? quantity;
  String? createdAt;
  int? adminStatus;
  String? adminReply;

  FarmerFormTextileForm(
      {this.id,
        this.farmerFormId,
        this.textileManufacturerId,
        this.garmentManufacturerId,
        this.fabricMethod,
        this.fabricProductionDate,
        this.typesFabric,
        this.dyeingMethod,
        this.dyeingChemical,
        this.dyeingDate,
        this.qualityWeight,
        this.qualityWidth,
        this.qualityColor,
        this.qualityShrinkage,
        this.quantity,
        this.createdAt,
        this.adminStatus,
        this.adminReply});

  FarmerFormTextileForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    textileManufacturerId = json['textile_manufacturer_id'];
    garmentManufacturerId = json['garment_manufacturer_id'];
    fabricMethod = json['fabric_method'];
    fabricProductionDate = json['fabric_production_date'];
    typesFabric = json['types_fabric'];
    dyeingMethod = json['dyeing_method'];
    dyeingChemical = json['dyeing_chemical'];
    dyeingDate = json['dyeing_date'];
    qualityWeight = json['quality_weight'];
    qualityWidth = json['quality_width'];
    qualityColor = json['quality_color'];
    qualityShrinkage = json['quality_shrinkage'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    adminStatus = json['admin_status'];
    adminReply = json['admin_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['textile_manufacturer_id'] = this.textileManufacturerId;
    data['garment_manufacturer_id'] = this.garmentManufacturerId;
    data['fabric_method'] = this.fabricMethod;
    data['fabric_production_date'] = this.fabricProductionDate;
    data['types_fabric'] = this.typesFabric;
    data['dyeing_method'] = this.dyeingMethod;
    data['dyeing_chemical'] = this.dyeingChemical;
    data['dyeing_date'] = this.dyeingDate;
    data['quality_weight'] = this.qualityWeight;
    data['quality_width'] = this.qualityWidth;
    data['quality_color'] = this.qualityColor;
    data['quality_shrinkage'] = this.qualityShrinkage;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['admin_status'] = this.adminStatus;
    data['admin_reply'] = this.adminReply;
    return data;
  }
}



