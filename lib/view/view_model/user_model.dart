import 'dart:convert';

LoginResponseData loginResponseDataFromJson(String str) =>
    LoginResponseData.fromJson(json.decode(str));

String loginResponseDataToJson(LoginResponseData data) =>
    json.encode(data.toJson());

class LoginResponseData {
  Data? data;
  User? user;

  LoginResponseData({this.data, this.user});

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  int? copmId;
  String? name;
  Null? email;
  int? mobileNo;
  Null? emailVerifiedAt;
  String? apiToken;
  int? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.copmId,
      this.name,
      this.email,
      this.mobileNo,
      this.emailVerifiedAt,
      this.apiToken,
      this.role,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    copmId = json['copm_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['copm_id'] = this.copmId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['api_token'] = this.apiToken;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
// import 'dart:convert';

// LoginResponseData loginResponseDataFromJson(String str) =>
//     LoginResponseData.fromJson(json.decode(str));

// String loginResponseDataToJson(LoginResponseData data) =>
//     json.encode(data.toJson());

// class LoginResponseData {
//   LoginResponseData({
//     this.data,
//     this.user,
//   });

//   Data? data;
//   User? user;

//   factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
//       LoginResponseData(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//         "user": user?.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.token,
//   });

//   String? token;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         token: json["token"],
//       );

//   Map<String, dynamic> toJson() => {
//         "token": token,
//       };
// }

// class User {
//   int? id;
//   int? copmId;
//   String? name;
//   Null? email;
//   int? mobileNo;
//   Null? emailVerifiedAt;
//   //String? apiToken;
//   int? role;
//   String? createdAt;
//   String? updatedAt;

//   User(
//       {this.id,
//       this.copmId,
//       this.name,
//       this.email,
//       this.mobileNo,
//       this.emailVerifiedAt,
//       // this.apiToken,
//       this.role,
//       this.createdAt,
//       this.updatedAt});

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json['id'],
//         copmId: json['copm_id'],
//         name: json['name'],
//         email: json['email'],
//         mobileNo: json['mobile_no'],
//         emailVerifiedAt: json['email_verified_at'],
//         // apiToken: json['api_token'],
//         role: json['role'],
//         createdAt: json['created_at'],
//         updatedAt: json['updated_at'],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "copm_id ": copmId,
//         " name": name,
//         " mobile_no": mobileNo,
//         " email_verified_at": emailVerifiedAt,
//         " role": role,
//         " created_at": createdAt,
//         " updated_at": updatedAt,
//         // Map<String, dynamic> toJson() {
//         //   final Map<String, dynamic> data = new Map<String, dynamic>();
//         //   data['id'] = this.id;
//         //   data['copm_id'] = this.copmId;
//         //   data['name'] = this.name;
//         //   data['email'] = this.email;
//         //   data['mobile_no'] = this.mobileNo;
//         //   data['email_verified_at'] = this.emailVerifiedAt;
//         //   data['api_token'] = this.apiToken;
//         //   data['role'] = this.role;
//         //   data['created_at'] = this.createdAt;
//         //   data['updated_at'] = this.updatedAt;
//         //   return data;
//       };
// }
