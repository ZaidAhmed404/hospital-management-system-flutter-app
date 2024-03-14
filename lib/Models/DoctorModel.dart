class DoctorModel {
  String userId;
  String name;
  String photoUrl;
  String address;
  String cnic;
  String phoneNumber;
  String gender;
  String licenseNumber;
  String specialization;
  String hourlyRate;
  String cardNumber;

  DoctorModel(
      {required this.address,
      required this.cnic,
      required this.phoneNumber,
      required this.gender,
      required this.licenseNumber,
      required this.specialization,
      required this.name,
      required this.photoUrl,
      required this.cardNumber,
      required this.hourlyRate,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'cardNumber': cardNumber,
      'hourlyRate': hourlyRate,
      'userId': userId
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
        address: map['address'] ?? "",
        cnic: map['cnic'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        gender: map['gender'] ?? "",
        licenseNumber: map['licenseNumber'] ?? "",
        specialization: map['specialization'] ?? "",
        photoUrl: map['photoUrl'] ?? "",
        name: map['name'] ?? "",
        cardNumber: map['cardNumber'] ?? "",
        hourlyRate: map['hourlyRate'] ?? "",
        userId: map['userId'] ?? "");
  }
}
