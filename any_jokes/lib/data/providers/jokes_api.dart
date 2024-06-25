import 'dart:convert';
import 'package:http/http.dart' as http;

class JokesApi {
  static const String baseUrl = 'https://v2.jokeapi.dev/joke/Any';

  Future<List<Joke>> fetchJokes({String? category, String? search, int count = 5}) async {
    List<Joke> jokes = [];
    for (int i = 0; i < count; i++) {
      final url = Uri.parse(
          '$baseUrl?type=twopart${category != null ? '&category=$category' : ''}${search != null ? '&contains=$search' : ''}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData); // Debug: Print the response body

        if (jsonData['error'] == false) {
          if (jsonData['type'] == 'twopart') {
            jokes.add(Joke.fromJson(jsonData));
          }
        } else {
          throw Exception('Failed to fetch jokes');
        }
      } else {
        throw Exception('Failed to fetch jokes');
      }
    }
    return jokes;
  }
}

class Joke {
  final String id;
  final String setup;
  final String punchline;

  Joke({required this.id, required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'].toString(),
      setup: json['setup'],
      punchline: json['delivery'],
    );
  }
}
