import 'dart:convert';
import 'package:http/http.dart' as http;

class JokesApi {
  static const String baseUrl = 'https://v2.jokeapi.dev/';

  Future<List<Joke>> fetchJokes() async {
    final response = await http.get(Uri.parse('$baseUrl/jokes'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['error'] == false) {
        final jokesData = jsonData['jokes'];
        return List<Joke>.from(jokesData.map((joke) => Joke.fromJson(joke)));
      } else {
        throw Exception('Failed to fetch jokes');
      }
    } else {
      throw Exception('Failed to fetch jokes');
    }
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
