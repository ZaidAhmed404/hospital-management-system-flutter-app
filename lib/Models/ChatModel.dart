class ChatModel {
  final String patientId;
  final String patientName;
  final String patientPhotoUrl;
  final String doctorId;
  final String doctorName;
  final String doctorPhotoUrl;
  final String date;
  final String message;
  final String time;
  final String sendBy;

  ChatModel(
      {required this.patientId,
      required this.patientName,
      required this.patientPhotoUrl,
      required this.doctorId,
      required this.doctorName,
      required this.doctorPhotoUrl,
      required this.date,
      required this.message,
      required this.time,
      required this.sendBy});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        patientId: json['patientId'] ?? "",
        patientName: json['patientName'] ?? "",
        patientPhotoUrl: json['patientPhotoUrl'] ?? "",
        doctorId: json['doctorId'] ?? "",
        doctorName: json['doctorName'] ?? "",
        doctorPhotoUrl: json['doctorPhotoUrl'] ?? "",
        date: json['date'] ?? "",
        message: json['message'] ?? "",
        time: json['time'] ?? "",
        sendBy: json['sendBy'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "patientName": patientName,
      "patientPhotoUrl": patientPhotoUrl,
      "doctorId": doctorId,
      "doctorName": doctorName,
      "doctorPhotoUrl": doctorPhotoUrl,
      "date": date,
      "message": message,
      "time": time,
      'sendBy': sendBy
    };
  }
}
