class AppointmentModel {
  final String appointmentDate;
  final String date;
  final String description;
  final String doctorId;
  final String doctorName;
  final String doctorPhotoUrl;
  final String endTime;
  final String name;
  final String patientId;
  final String patientName;
  final String patientPhotoUrl;
  final String startTime;
  final String timeSlot;

  AppointmentModel({
    required this.appointmentDate,
    required this.date,
    required this.description,
    required this.doctorId,
    required this.doctorName,
    required this.doctorPhotoUrl,
    required this.endTime,
    required this.name,
    required this.patientId,
    required this.patientName,
    required this.patientPhotoUrl,
    required this.startTime,
    required this.timeSlot,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentDate: json['appointmentDate'],
      date: json['date'],
      description: json['description'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      doctorPhotoUrl: json['doctorPhotoUrl'],
      endTime: json['endTime'],
      name: json['name'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      patientPhotoUrl: json['patientPhotoUrl'],
      startTime: json['startTime'],
      timeSlot: json['timeSlot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentDate': appointmentDate,
      'date': date,
      'description': description,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorPhotoUrl': doctorPhotoUrl,
      'endTime': endTime,
      'name': name,
      'patientId': patientId,
      'patientName': patientName,
      'patientPhotoUrl': patientPhotoUrl,
      'startTime': startTime,
      'timeSlot': timeSlot,
    };
  }
}
