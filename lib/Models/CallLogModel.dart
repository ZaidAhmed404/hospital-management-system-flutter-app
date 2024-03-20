class CallLogModel {
  final String callerId;
  final String callerName;
  final String callerPhotoUrl;
  final String targetUserId;
  final String targetUserName;
  final String targetUserPhotoUrl;
  final String callType;
  final String date;
  final String time;

  CallLogModel(
      {required this.callerId,
      required this.callerName,
      required this.callerPhotoUrl,
      required this.targetUserId,
      required this.targetUserName,
      required this.targetUserPhotoUrl,
      required this.callType,
      required this.date,
      required this.time});

  factory CallLogModel.fromJson(Map<String, dynamic> json) {
    return CallLogModel(
        callerId: json['callerId'],
        callerName: json['callerName'],
        callerPhotoUrl: json['callerPhotoUrl'],
        targetUserId: json['targetUserId'],
        targetUserName: json['targetUserName'],
        targetUserPhotoUrl: json['targetUserPhotoUrl'],
        callType: json['callType'],
        date: json['date'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['callerId'] = callerId;
    data['callerName'] = callerName;
    data['callerPhotoUrl'] = callerPhotoUrl;
    data['targetUserId'] = targetUserId;
    data['targetUserName'] = targetUserName;
    data['targetUserPhotoUrl'] = targetUserPhotoUrl;
    data['callType'] = callType;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
