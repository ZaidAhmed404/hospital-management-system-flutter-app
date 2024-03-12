class MedicineModel {
  String name;
  String quantity;
  String date;

  MedicineModel({
    required this.name,
    required this.quantity,
    required this.date,
  });

  MedicineModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        quantity = map['quantity'],
        date = map['date'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'date': date,
    };
  }
}
