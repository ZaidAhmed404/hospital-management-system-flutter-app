class PatientModel {
  String address;
  String cnic;
  String phoneNumber;
  String gender;

  PatientModel({
    required this.address,
    required this.cnic,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      address: map['address'],
      cnic: map['cnic'],
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
    );
  }
}
