class LoanModel {
  String? message;
  bool? status;
  int? code;
  List<Data>? data;

  LoanModel({this.message, this.status, this.code, this.data});

  LoanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? lId;
  String? cId;
  int? loanAmount;
  int? dailyDueAmount;
  int? balanceAmount;
  String? collectionDate;
  String? collectedBy;
  Null? companyId;
  String? deleted;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? customerId;
  int? contactNo;
  String? address;

  Data(
      {this.lId,
      this.cId,
      this.loanAmount,
      this.dailyDueAmount,
      this.balanceAmount,
      this.collectionDate,
      this.collectedBy,
      this.companyId,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.customerId,
      this.contactNo,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    lId = json['l_id'];
    cId = json['c_id'];
    loanAmount = json['loan_amount'];
    dailyDueAmount = json['daily_due_amount'];
    balanceAmount = json['balance_amount'];
    collectionDate = json['collection_date'];
    collectedBy = json['collected_by'];
    companyId = json['company_id'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    customerId = json['customer_id'];
    contactNo = json['contact_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['l_id'] = this.lId;
    data['c_id'] = this.cId;
    data['loan_amount'] = this.loanAmount;
    data['daily_due_amount'] = this.dailyDueAmount;
    data['balance_amount'] = this.balanceAmount;
    data['collection_date'] = this.collectionDate;
    data['collected_by'] = this.collectedBy;
    data['company_id'] = this.companyId;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['customer_id'] = this.customerId;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    return data;
  }
}
