import 'dart:convert';
import 'package:aqar_plus/core/config.dart';
import 'package:http/http.dart' as http;

class RatingServices {
  final url = Uri.parse('${Config.baseUrl}${Config.addRatingUser}');

  Future<void> addRating(int? property_id, int? rating) async {
    final body = {"property_id": property_id, "rating": rating};

     final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer 1|znY8JP6kgHaLWmGRbKFQ0PoVq1YRul7P3xhVJ1yude44d3ad'
        // SheredPreferance.token
      },
      body: jsonEncode(body),
    );
    
    print(response.statusCode);
    print("response.body" + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      throw Exception("استجابة غير متوقعة من السيرفر");
    } else {
      throw Exception("فشل في تحميل البيانات: ${response.statusCode}");
    }
  }

}
