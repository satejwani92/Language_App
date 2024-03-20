// import 'package:final_lang/reading/phrase.dart';
import 'package:final_lang/reading/phrase.dart';
import 'package:final_lang/reading/conversation.dart';
import 'package:final_lang/reading/alphabets.dart';
// import 'package:final_lang/reading/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:final_lang/learning/progress.dart';
import 'package:final_lang/progress_brain.dart/progress.dart';
import 'package:hive/hive.dart';

import '../../reading/vocabulary.dart';

class Reading extends StatefulWidget {
  late ColorScheme dync;
  Reading({required this.dync});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  late var lang;

  List<Map<String, dynamic>> Alphabets = [];

  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    lang = box.get("Lang")[n.toString()]["Selected_lang"];

    // log(box.get("Lang").toString());

    if (lang[0] == 'German') {
      // Populate sentences with German content
      Alphabets =[];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      Alphabets = [];
    } else if(lang[0]=='Russian'){
      Alphabets =[];
    }
    else if(lang[0]=='Japanese'){
      Alphabets =[];
    }
    else if(lang[0]=='Korean'){
      Alphabets=[];
    }
    else if(lang[0]=='Malayalam'){
      Alphabets=[];
    }
    else{
      Alphabets= [];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.dync.inversePrimary,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(child: Text("Reading",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return Alphabetsokay();
            }));
          },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
                onPrimary: Colors.white, // Text color
                elevation: 5, // Elevation (shadow)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15), // Button padding
              ),child: const Text("Alphabets")),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return Vocabularyokay();
            }));
          },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
                onPrimary: Colors.white, // Text color
                elevation: 5, // Elevation (shadow)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15), // Button padding
              ),child: const Text("vocabulary")),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return Conversation();
            }));
          }, style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Background color
            onPrimary: Colors.white, // Text color
            elevation: 5, // Elevation (shadow)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15), // Button padding
          ),
              child: const Text("Conversations")),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return PhraseMatchingGame();
            }));
          },style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Background color
            onPrimary: Colors.white, // Text color
            elevation: 5, // Elevation (shadow)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15), // Button padding
          ),
              child: const Text("Phrases")),
        ],
      ),
    );
  }
}





List<String> categories = [
  "Vocabulary",
  "Phrases and Expressions",
  "Grammar",
  "Dialogues and Conversations",
  "Cultural Insights",
];