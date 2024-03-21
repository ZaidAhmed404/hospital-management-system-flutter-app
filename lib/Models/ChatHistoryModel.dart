class ChatHistoryModel {
  final String patientId;
  final String patientName;
  final String patientPhotoUrl;
  final String doctorId;
  final String doctorName;
  final String doctorPhotoUrl;
  final String startTime;
  final String endTime;
  final String appointmentDate;
  final String date;

  ChatHistoryModel(
      {required this.patientId,
      required this.patientName,
      required this.patientPhotoUrl,
      required this.doctorId,
      required this.doctorName,
      required this.doctorPhotoUrl,
      required this.startTime,
      required this.appointmentDate,
      required this.date,
      required this.endTime});

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
        patientId: json['patientId'] ?? "",
        patientName: json['patientName'] ?? "",
        patientPhotoUrl: json['patientPhotoUrl'] ?? "",
        doctorId: json['doctorId'] ?? "",
        doctorName: json['doctorName'] ?? "",
        doctorPhotoUrl: json['doctorPhotoUrl'] ?? "",
        startTime: json['startTime'] ?? "",
        appointmentDate: json['appointmentDate'] ?? "",
        date: json['date'] ?? "",
        endTime: json['endTime'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "patientName": patientName,
      "patientPhotoUrl": patientPhotoUrl,
      "doctorId": doctorId,
      "doctorName": doctorName,
      "doctorPhotoUrl": doctorPhotoUrl,
      "startTime": startTime,
      "appointmentDate": appointmentDate,
      "date": date,
      "endTime": endTime
    };
  }
}
