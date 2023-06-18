import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fin/models/BaseClients.dart';

class CustomerModel {
  String? message;
  bool? status;
  int? code;
  List<Data>? data;

  CustomerModel({this.message, this.status, this.code, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
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

  static saveCustomer(name, contactNo, address, dailyDueAmount, loanAmount,
      loanDuration) async {
    Map<String, String> body = {
      "name": name,
      "contact_no": contactNo,
      "address": address,
      "loan_amount": loanAmount,
      "daily_due_amount": dailyDueAmount,
      "loan_duration": loanDuration,
      // "company_zipcode": companyZipcode,
    };
    final jsonBody = jsonEncode(body);
    String jsonResponse;
    // var url = baseUrl + '/customers/';
    Uri url = Uri.parse("https://product.artsify.in/public/api/customers/");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYWIxZDI2NDRlZTA3MjQ1ZTc0OWZjMGQwODY0NjU5MjUzODFmZDViOGE4NjVjM2M3ZjFkOTc2MGEyODM1ZTY3NWI0NTNmNjE4NjMwNWE3OGYiLCJpYXQiOjE2ODY5OTIwNzMuOTYyMDczMDg3NjkyMjYwNzQyMTg3NSwibmJmIjoxNjg2OTkyMDczLjk2MjA3NDk5NTA0MDg5MzU1NDY4NzUsImV4cCI6MTcxODYxNDQ3My45NjExMDcwMTU2MDk3NDEyMTA5Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.xDE8hUgW3BaAtfuj6omFEbT_Ze84LpvHMDTDDoisft1MtphvmXSyNhv8TyiFNMcFQuHWOfn6mJVRPwiExRmA--zGsHUXBt2opYrbGohE2yIL8qZL6zI6H5x8S8Nq8WC_T4hudKgsNzASVGGAQHhYbG7jMXOYPlxOJjGTlD-kY87153oiNcibrK36wmD-7YFgjnQBRBwYsdv_tvyKIjgdu2TEgwBS2JU6VngsZKz9va-Vi2kTrnGW5nw8sA_OgndCMjzvkU95AI9XSnMG-da56etMpBTtwlA9F_g7xzVJCh48ANTFkxybKzOyjhXJzlhgllef-4Heb9K7pSbNPCOJJPRvEou3bAsns58PrPC0fsroBDuLrtxw5_heVdsVoWCM0ZOQPIo7a1zR4_72oE73guhBM67kNiJxCcLccqbrbZ-xyZf3JB7CdRswpJTcVWvz9rcagvP_T1dQ8UugOjj4rN0sWqTLe4PKytB1lDji7Lni37Z4BqVgvvlo2b62UDzyLLyOSIau6jDXXVwsC2e4XErSqfygMLzIfY9Hw9yD4CrIcE07icbTiJCzYkncMFBffnUFnHB5ppZdHWiw3xKjAvYiTtjdflGqOhqjFcF67wpnUffxtNOVKvxUxSSKJWupsBhEdxTxNSzxUi4DjVvElciV0ui0TE2nDkicK8-zbDI'
    };
    // var response = await BaseClient.post(url, body);
    var response = await http.post(url, body: jsonBody, headers: headers);

    if (response.statusCode == 200) {
      jsonResponse = response.body.toString();
      Map notificationResult = jsonDecode(jsonResponse.toString());
      return response = notificationResult as http.Response;
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }
}

class Data {
  int? cId;
  String? customerId;
  String? name;
  int? contactNo;
  String? address;
  int? loanAmount;
  int? balanceAmount;
  int? dailyDueAmount;
  String? loanDuration;
  String? startingDate;
  int? companyId;
  Null? createdBy;
  Null? updatedBy;
  String? active;
  String? deleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.cId,
      this.customerId,
      this.name,
      this.contactNo,
      this.address,
      this.loanAmount,
      this.balanceAmount,
      this.dailyDueAmount,
      this.loanDuration,
      this.startingDate,
      this.companyId,
      this.createdBy,
      this.updatedBy,
      this.active,
      this.deleted,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    customerId = json['customer_id'];
    name = json['name'];
    contactNo = json['contact_no'];
    address = json['address'];
    loanAmount = json['loan_amount'];
    balanceAmount = json['balance_amount'];
    dailyDueAmount = json['daily_due_amount'];
    loanDuration = json['loan_duration'];
    startingDate = json['starting_date'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    active = json['active'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_id'] = this.cId;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['loan_amount'] = this.loanAmount;
    data['balance_amount'] = this.balanceAmount;
    data['daily_due_amount'] = this.dailyDueAmount;
    data['loan_duration'] = this.loanDuration;
    data['starting_date'] = this.startingDate;
    data['company_id'] = this.companyId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
