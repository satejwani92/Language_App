import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';

var box = Hive.box("LocalDB");

class Listening extends StatefulWidget {
  late ColorScheme dync;
  Listening({required this.dync});

  @override
  State<Listening> createState() => _ListeningState();
}

class _ListeningState extends State<Listening> {
  late Future<List<String>> onetimebuilder;
  var lang =
      box.get("Lang")[box.get("current_lang").toString()]['Selected_lang'];
  String selectedLanguage = 'English';

  FlutterTts flutterTts = FlutterTts();

  Future<List<String>> fetchListeningData(String language) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('LISTENING')
          .where('language', isEqualTo: language)
          .get();

      List<String> texts = querySnapshot.docs
          .map((QueryDocumentSnapshot document) => document['text'] as String)
          .toList();

      return texts;
    } catch (error) {
      log('Error fetching listening data: $error');
      return [];
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage(lang[0]);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    onetimebuilder = fetchListeningData(selectedLanguage);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: widget.dync.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Listening",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                    onetimebuilder = fetchListeningData(selectedLanguage);
                  });
                },
                items: ['English', 'Spanish', 'French']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.28,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<String>>(
                  future: onetimebuilder,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                snapshot.data![index],
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  speak(snapshot.data![index]);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
