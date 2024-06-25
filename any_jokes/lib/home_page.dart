import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/providers/jokes_api.dart';

class AnyJokes extends StatelessWidget {
  const AnyJokes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Any';
  Future<List<Joke>>? _jokesFuture;

  void _searchJokes() {
    setState(() {
      _jokesFuture = JokesApi().fetchJokes(
        category: _selectedCategory == 'Any' ? null : _selectedCategory,
        search: _searchController.text,
        count: 5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 90, 14, 151),
              Color.fromARGB(209, 83, 21, 150),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                    'Category',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    items: <String>[
                      'Any',
                      'Programming',
                      'Misc',
                      'Dark',
                      'Pun',
                      'Spooky',
                      'Christmas'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors.white), 
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    dropdownColor: Colors.grey[800],
                    iconEnabledColor:
                        Colors.white, 
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for jokes...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _searchJokes,
                    child: const Text(
                      'Search Jokes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Joke>>(
                future: _jokesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(16),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'No jokes to show..Try browsing for jokes',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final joke = snapshot.data![index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  joke.setup,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  joke.punchline,
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
