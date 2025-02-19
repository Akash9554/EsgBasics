import 'dart:convert';

FarmerFormListResponce formrouteModelFromJson(String str) => FarmerFormListResponce.fromJson(json.decode(str));

String formrouteModelToJson(FarmerFormListResponce data) => json.encode(data.toJson());

class FarmerFormListResponce {
  String? errorCode;
  String? errorMsg;
  List<FormData>? data;

  FarmerFormListResponce({this.errorCode, this.errorMsg, this.data});

  FarmerFormListResponce.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <FormData>[];
      json['data'].forEach((v) {
        data!.add(new FormData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormData {
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
  dynamic? pesticidesAmount;
  String? harvesting;
  String? video;
  int? status;
  String? reply;
  String? createdAt;
  dynamic? unitPrice;
  dynamic? location;
  dynamic? rainFedOnly;
  String? farmerFormInvoiceQrCode;
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
  GarmentInvoice? garmentInvoice;
  FarmerFormGarmentForm? farmerFormGarmentForm;

  FormData(
      {this.id,
        this.farmerId,
        this.ginnerId,
        this.plantingDate,
        this.cottonVarietyId,
        this.expectedYield,
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
        this.unitPrice,
        this.location,
        this.rainFedOnly,
        this.farmerFormInvoiceQrCode,
        this.farmerDetail,
        this.ginnerInvoice,
        this.ginnerDetail,
        this.ginnerInvoiceSpinner,
        this.spinnerDetail,
        this.spinnerInvoice,
        this.farmerFormSpinnerForm,
        this.textileManufacturerDetail,
        this.textileInvoice,
        this.farmerFormTextileForm,
        this.garmentInvoice,
        this.farmerFormGarmentForm});

  FormData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    ginnerId = json['ginner_id'];
    plantingDate = json['planting_date'];
    cottonVarietyId = json['cotton_variety_id'];
    expectedYield = json['expected_yield'];
    typeFertilizationId = json['type_fertilization_id'];
    fertilizationAmount = json['fertilization_amount'];
    wateringSchedules = json['watering_schedules'];
    typePesticidesId = json['type_pesticides_id'];
    pesticidesAmount = json['pesticides_amount'];
    harvesting = json['harvesting'];
    video = json['video'];
    status = json['status'];
    reply = json['reply'];
    createdAt = json['created_at'];
    unitPrice = json['unit_price'];
    location = json['location'];
    rainFedOnly = json['rain_fed_only'];
    farmerFormInvoiceQrCode = json['farmer_form_invoice_qr_code'];
    farmerDetail = json['farmer_detail'] != null
        ? new FarmerDetail.fromJson(json['farmer_detail'])
        : null;
    ginnerInvoice = json['ginner_invoice'] != null
        ? new GinnerInvoice.fromJson(json['ginner_invoice'])
        : null;
    ginnerDetail = json['ginner_detail'] != null
        ? new FarmerDetail.fromJson(json['ginner_detail'])
        : null;
    ginnerInvoiceSpinner = json['ginner_invoice_spinner'] != null
        ? new GinnerInvoiceSpinner.fromJson(json['ginner_invoice_spinner'])
        : null;
    spinnerDetail = (json['spinner_detail'] is Map<String, dynamic>)
        ? FarmerDetail.fromJson(json['spinner_detail'])
        : null;
    spinnerInvoice = json['spinner_invoice'] != null
        ? new SpinnerInvoice.fromJson(json['spinner_invoice'])
        : null;
    farmerFormSpinnerForm = json['farmer_form_spinner_form'] != null
        ? new FarmerFormSpinnerForm.fromJson(json['farmer_form_spinner_form'])
        : null;
    textileManufacturerDetail = (json['textile_manufacturer_detail'] != null && json['textile_manufacturer_detail'] != "")
        ? FarmerDetail.fromJson(json['textile_manufacturer_detail'])
        : null;

    textileInvoice = json['textile_invoice'] != null
        ? new TextileInvoice.fromJson(json['textile_invoice'])
        : null;
    farmerFormTextileForm = json['farmer_form_textile_form'] != null
        ? new FarmerFormTextileForm.fromJson(json['farmer_form_textile_form'])
        : null;
    garmentInvoice = json['garment_invoice'] != null
        ? new GarmentInvoice.fromJson(json['garment_invoice'])
        : null;
    farmerFormGarmentForm = json['farmer_form_garment_form'] != null
        ? new FarmerFormGarmentForm.fromJson(json['farmer_form_garment_form'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['ginner_id'] = this.ginnerId;
    data['planting_date'] = this.plantingDate;
    data['cotton_variety_id'] = this.cottonVarietyId;
    data['expected_yield'] = this.expectedYield;
    data['type_fertilization_id'] = this.typeFertilizationId;
    data['fertilization_amount'] = this.fertilizationAmount;
    data['watering_schedules'] = this.wateringSchedules;
    data['type_pesticides_id'] = this.typePesticidesId;
    data['pesticides_amount'] = this.pesticidesAmount;
    data['harvesting'] = this.harvesting;
    data['video'] = this.video;
    data['status'] = this.status;
    data['reply'] = this.reply;
    data['created_at'] = this.createdAt;
    data['unit_price'] = this.unitPrice;
    data['location'] = this.location;
    data['rain_fed_only'] = this.rainFedOnly;
    data['farmer_form_invoice_qr_code'] = this.farmerFormInvoiceQrCode;
    if (this.farmerDetail != null) {
      data['farmer_detail'] = this.farmerDetail!.toJson();
    }
    if (this.ginnerInvoice != null) {
      data['ginner_invoice'] = this.ginnerInvoice!.toJson();
    }
    if (this.ginnerDetail != null) {
      data['ginner_detail'] = this.ginnerDetail!.toJson();
    }
    if (this.ginnerInvoiceSpinner != null) {
      data['ginner_invoice_spinner'] = this.ginnerInvoiceSpinner!.toJson();
    }
    if (this.spinnerDetail != null) {
      data['spinner_detail'] = this.spinnerDetail!.toJson();
    }
    if (this.spinnerInvoice != null) {
      data['spinner_invoice'] = this.spinnerInvoice!.toJson();
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
    if (this.garmentInvoice != null) {
      data['garment_invoice'] = this.garmentInvoice!.toJson();
    }
    if (this.farmerFormGarmentForm != null) {
      data['farmer_form_garment_form'] = this.farmerFormGarmentForm!.toJson();
    }
    return data;
  }
}

class FarmerDetail {
  int? id;
  int? userType;
  String? name;
  String? email;
  String? address;
  String? mobileNo;
  String? deviceType;
  String? deviceToken;
  String? otp;
  String? createdAt;
  String? qrCode;
  String? profile_qr_code;

  FarmerDetail(
      {this.id,
        this.userType,
        this.name,
        this.email,
        this.address,
        this.mobileNo,
        this.deviceType,
        this.deviceToken,
        this.otp,
        this.createdAt,
        this.qrCode,
      this.profile_qr_code});

  FarmerDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    otp = json['otp'];
    createdAt = json['created_at'];
    qrCode = json['qr_code'];
    profile_qr_code = json['profile_qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['mobile_no'] = this.mobileNo;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['otp'] = this.otp;
    data['created_at'] = this.createdAt;
    data['qr_code'] = this.qrCode;
    data['profile_qr_code']=this.profile_qr_code;
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
  int? adminStatus;

  GinnerInvoice(
      {this.id,
        this.farmerFormId,
        this.ginnerId,
        this.qty,
        this.price,
        this.totalPrice,
        this.createdAt,
        this.farmerStatus,
        this.adminStatus,
      });

  GinnerInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    ginnerId = json['ginner_id'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    farmerStatus = json['farmer_status'];
    adminStatus = json['admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['ginner_id'] = this.ginnerId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['farmer_status'] = this.farmerStatus;
    data['admin_status'] = this.adminStatus;
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
  String? unitPrice;
  int? adminStatus;
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
        this.unitPrice,
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
    unitPrice = json['unit_price'];
    adminStatus = json['admin_status'];
    adminReply = json['admin_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['ginner_id'] = this.ginnerId;
    data['spinner_id'] = this.spinnerId;
    data['location'] = this.location;
    data['date_ginning'] = this.dateGinning;
    data['grade'] = this.grade;
    data['staple_length'] = this.stapleLength;
    data['strength'] = this.strength;
    data['quantity_after_ginning'] = this.quantityAfterGinning;
    data['created_at'] = this.createdAt;
    data['unit_price'] = this.unitPrice;
    data['admin_status'] = this.adminStatus;
    data['admin_reply'] = this.adminReply;
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
        this.adminStatus,
      });

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['spinner_id'] = this.spinnerId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['ginner_status'] = this.ginnerStatus;
    data['admin_status'] = this.adminStatus;

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
  dynamic? unitPrice;
  int? adminStatus;
  String? adminReply;

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
        this.unitPrice,
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
    unitPrice = json['unit_price'];
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
    data['unit_price'] = this.unitPrice;
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
        this.adminStatus,
        });

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
  String? unitPrice;
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
        this.unitPrice,
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
    unitPrice = json['unit_price'];
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
    data['unit_price'] = this.unitPrice;
    data['admin_status'] = this.adminStatus;
    data['admin_reply'] = this.adminReply;
    return data;
  }
}

class GarmentInvoice {
  int? id;
  int? farmerFormId;
  int? garmentManufacturerId;
  dynamic? qty;
  String? price;
  String? totalPrice;
  String? createdAt;
  int? textileStatus;
  int? adminStatus;


  GarmentInvoice(
      {this.id,
        this.farmerFormId,
        this.garmentManufacturerId,
        this.qty,
        this.price,
        this.totalPrice,
        this.createdAt,
        this.textileStatus,
        this.adminStatus,
        });

  GarmentInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    garmentManufacturerId = json['garment_manufacturer_id'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    textileStatus = json['textile_status'];
    adminStatus = json['admin_status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['garment_manufacturer_id'] = this.garmentManufacturerId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['textile_status'] = this.textileStatus;
    data['admin_status'] = this.adminStatus;

    return data;
  }
}

class FarmerFormGarmentForm {
  int? id;
  int? farmerFormId;
  int? garmentManufacturerId;
  String? dateFabric;
  String? productionCutting;
  String? productionSewing;
  String? productionAssemblingDates;
  String? garmentsDesign;
  String? garmentsSize;
  String? garmentsLabels;
  String? touchesIroning;
  String? touchesPackaging;
  String? finalQualityDefects;
  String? finalGarmentQuality;
  String? quantity;
  String? createdAt;
  String? unitPrice;
  int? adminStatus;
  String? adminReply;

  FarmerFormGarmentForm(
      {this.id,
        this.farmerFormId,
        this.garmentManufacturerId,
        this.dateFabric,
        this.productionCutting,
        this.productionSewing,
        this.productionAssemblingDates,
        this.garmentsDesign,
        this.garmentsSize,
        this.garmentsLabels,
        this.touchesIroning,
        this.touchesPackaging,
        this.finalQualityDefects,
        this.finalGarmentQuality,
        this.quantity,
        this.createdAt,
        this.unitPrice,
        this.adminStatus,
        this.adminReply});

  FarmerFormGarmentForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerFormId = json['farmer_form_id'];
    garmentManufacturerId = json['garment_manufacturer_id'];
    dateFabric = json['date_fabric'];
    productionCutting = json['production_cutting'];
    productionSewing = json['production_sewing'];
    productionAssemblingDates = json['production_assembling_dates'];
    garmentsDesign = json['garments_design'];
    garmentsSize = json['garments_size'];
    garmentsLabels = json['garments_labels'];
    touchesIroning = json['touches_ironing'];
    touchesPackaging = json['touches_packaging'];
    finalQualityDefects = json['final_quality_defects'];
    finalGarmentQuality = json['final_garment_quality'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    unitPrice = json['unit_price'];
    adminStatus = json['admin_status'];
    adminReply = json['admin_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_form_id'] = this.farmerFormId;
    data['garment_manufacturer_id'] = this.garmentManufacturerId;
    data['date_fabric'] = this.dateFabric;
    data['production_cutting'] = this.productionCutting;
    data['production_sewing'] = this.productionSewing;
    data['production_assembling_dates'] = this.productionAssemblingDates;
    data['garments_design'] = this.garmentsDesign;
    data['garments_size'] = this.garmentsSize;
    data['garments_labels'] = this.garmentsLabels;
    data['touches_ironing'] = this.touchesIroning;
    data['touches_packaging'] = this.touchesPackaging;
    data['final_quality_defects'] = this.finalQualityDefects;
    data['final_garment_quality'] = this.finalGarmentQuality;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['unit_price'] = this.unitPrice;
    data['admin_status'] = this.adminStatus;
    data['admin_reply'] = this.adminReply;
    return data;
  }
}
