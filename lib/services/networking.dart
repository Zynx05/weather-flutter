import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingHelper {

  NetworkingHelper(this.url);
  final Uri url;

  Future getData()async{
        try {
          http.Response response = await http.get(url);
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            return data;

        } else {
          print('Failed to get weather data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      };
    }
  }

