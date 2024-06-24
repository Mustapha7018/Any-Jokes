import 'dart:convert';

import 'package:any_jokes/data/models/jokes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AnyJokes extends StatefulWidget {
  const AnyJokes({super.key});

  @override
  State<AnyJokes> createState() => _AnyJokesState();
}

class _AnyJokesState extends State<AnyJokes> {
  Future<Welcome> getJoke() async {
    final response = await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any'));
    if (response.statusCode == 200) {
    
        return Welcome.fromJson(json.decode(response.body));
    
    }
    throw Exception('Failed to fetch joke'); 
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.light, // Light icons
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 90, 14, 151),
                Color.fromARGB(209, 83, 21, 150)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
            child: FutureBuilder<Welcome>(
            future: getJoke(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
              } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  children: [
                  const Text(
                    'Any Jokes',
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Press the button below to get a joke',
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      snapshot.data?.joke ?? '',
                      style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      ),
                    ),
                    ),
                  ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  ),
                  onPressed: getJoke,
                  child: const Text(
                  'Get Joke',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
                ],
              );
              }
            },
            ),
          ),
          ),
        );
        }
      }
