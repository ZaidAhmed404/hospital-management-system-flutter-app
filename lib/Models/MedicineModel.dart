class MedicineModel {
  String docId;
  String name;
  String quantity;
  String date;
  String price;

  MedicineModel(
      {required this.docId,
      required this.name,
      required this.quantity,
      required this.date,
      required this.price});

  MedicineModel.fromMap(this.docId, Map<String, dynamic> map)
      : name = map['name'] ?? "",
        quantity = map['quantity'] ?? "",
        date = map['date'] ?? "",
        price = map['price'] ?? "";

  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity, 'date': date, "price": price};
  }
}
