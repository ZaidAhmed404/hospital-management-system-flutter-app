class DoctorModel {
  String address;
  String cnic;
  String phoneNumber;
  String gender;
  String licenseNumber;
  String specialization;

  DoctorModel({
    required this.address,
    required this.cnic,
    required this.phoneNumber,
    required this.gender,
    required this.licenseNumber,
    required this.specialization,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      address: map['address'],
      cnic: map['cnic'],
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
      licenseNumber: map['licenseNumber'],
      specialization: map['specialization'],
    );
  }
}
