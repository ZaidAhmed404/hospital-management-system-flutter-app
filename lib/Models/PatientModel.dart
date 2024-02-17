class PatientModel {
  String id;
  String address;
  String cnic;
  String phoneNumber;
  String gender;

  PatientModel({
    required this.id,
    required this.address,
    required this.cnic,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'],
      address: map['address'],
      cnic: map['cnic'],
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
    );
  }
}
