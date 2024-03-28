class MessageModel {
  final String name;
  final String role;
  final String email;
  final String subject;
  final String message;

  MessageModel({
    required this.name,
    required this.role,
    required this.email,
    required this.subject,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      name: json['name'] ?? "",
      role: json['role'] ?? "",
      email: json['email'] ?? "",
      subject: json['subject'] ?? "",
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'email': email,
      'subject': subject,
      'message': message,
    };
  }
}
