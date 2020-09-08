import 'package:flutter/cupertino.dart';

class Patient {
  int id, userid;
  String fullname, doctor, birthdate, phone, address;
  num sc;

  Patient(
      {this.id,
      this.fullname,
      this.birthdate,
      @required this.userid,
      @required this.doctor,
      this.sc,
      this.phone,
      this.address});

  Patient.fromMap(Map<String, dynamic> map) {
    id = map["patient_id"];
    fullname = map["patient_fullname"];
    doctor = map["patient_doctor"];
    birthdate = map["patient_birthdate"];
    phone = map["patient_phone"];
    address = map["patient_address"];
    sc = map["patient_sc"];
    userid = map["user_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "patient_id": id,
      "patient_fullname": fullname,
      "patient_doctor": doctor,
      "patient_birthdate": birthdate,
      "patient_phone": phone,
      "patient_address": address,
      "patient_sc": sc,
      "user_id": userid
    };
  }
}
