class PharmacyModel {
  final String ownerId;
  final String name;
  final String address;
  final String date;

  PharmacyModel({
    required this.ownerId,
    required this.name,
    required this.address,
    required this.date,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      ownerId: json['ownerId'] ?? "",
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      date: json['date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'name': name,
      'address': address,
      'date': date,
    };
  }
}
