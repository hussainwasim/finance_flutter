// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String message;
  bool status;
  int code;
  Data data;

  User({
    required this.message,
    required this.status,
    required this.code,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        status: json["status"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  String name;
  String? customerId;
  String contactNo;
  String address;
  String loanAmount;
  String balanceAmount;
  String dailyDueAmount;
  String loanDuration;
  DateTime startingDate;

  Data({
    required this.name,
    required this.customerId,
    required this.contactNo,
    required this.address,
    required this.loanAmount,
    required this.balanceAmount,
    required this.dailyDueAmount,
    required this.loanDuration,
    required this.startingDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        customerId: json["customer_id"],
        contactNo: json["contact_no"],
        address: json["address"],
        loanAmount: json["loan_amount"],
        balanceAmount: json["balance_amount"],
        dailyDueAmount: json["daily_due_amount"],
        loanDuration: json["loan_duration"],
        startingDate: DateTime.parse(json["starting_date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "customer_id": customerId,
        "contact_no": contactNo,
        "address": address,
        "loan_amount": loanAmount,
        "balance_amount": balanceAmount,
        "daily_due_amount": dailyDueAmount,
        "loan_duration": loanDuration,
        "starting_date": startingDate.toIso8601String(),
      };
}
