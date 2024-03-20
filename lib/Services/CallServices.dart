import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class CallServices {
  Future<List<dynamic>> getCallHistoryFromZegoCloud(
      {required String userId}) async {
    const String endpoint = 'https://example.zegocloud.com/api/call_history';

    try {
      final response = await http.get(
        Uri.parse('$endpoint?user_id=$userId'),
        headers: {
          'Authorization': 'Bearer 4363952',
          // Include your API key for authentication
        },
      );
      log("${response.body}", name: "call history");
      if (response.statusCode == 200) {
        List<dynamic> callHistory = json.decode(response.body);

        return callHistory;
      } else {
        throw Exception('Failed to fetch call history from ZegoCloud');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
