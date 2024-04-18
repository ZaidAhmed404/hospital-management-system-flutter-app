class RateModel {
  final String senderName;
  final String doctorId;
  final String rate;
  final String description;

  RateModel({
    required this.senderName,
    required this.doctorId,
    required this.rate,
    required this.description,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      senderName: json['senderName'] ?? "",
      doctorId: json['doctorId'] ?? "",
      rate: (json['rate'] ?? 0.0).toString(),
      description: json['description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'doctorId': doctorId,
      'rate': rate,
      'description': description,
    };
  }
}
