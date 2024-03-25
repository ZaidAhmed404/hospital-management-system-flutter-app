class OrderMedicineModel {
  final String name;
  final String userId;
  final List<Map<String, dynamic>> medicines;
  final String address;
  final String ownerId;
  final String total;
  final String status;
  final String date;

  OrderMedicineModel({
    required this.name,
    required this.userId,
    required this.medicines,
    required this.address,
    required this.ownerId,
    required this.total,
    required this.status,
    required this.date,
  });

  factory OrderMedicineModel.fromMap(Map<String, dynamic> map) {
    return OrderMedicineModel(
      name: map['name'],
      userId: map['userId'],
      medicines: List<Map<String, dynamic>>.from(map['medicines']),
      address: map['address'],
      ownerId: map['ownerId'],
      total: map['total'],
      status: map['status'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'medicines': medicines,
      'address': address,
      'ownerId': ownerId,
      'total': total,
      'status': status,
      'date': date,
    };
  }
}
