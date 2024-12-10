import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userEmail;
  String? accountRole;
  String? phoneNumber;
  String? adminId;
  DateTime? createdData;

  UserModel({this.userId, this.userEmail, this.accountRole, this.createdData});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userEmail = json['userEmail'];
    accountRole = json['accountRole'];
    phoneNumber = json['phoneNumber'];
    adminId = json['adminId'];
    createdData = (json['createdData'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userEmail'] = this.userEmail;
    data['accountRole'] = this.accountRole;
    data['phoneNumber'] = this.phoneNumber;
    data['adminId'] = this.adminId;
    data['createdData'] = this.createdData;
    return data;
  }
}
