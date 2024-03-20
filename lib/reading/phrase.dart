import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class PhraseMatchingGame extends StatefulWidget {
  @override
  _PhraseMatchingGameState createState() => _PhraseMatchingGameState();
}

class _PhraseMatchingGameState extends State<PhraseMatchingGame> {
  late var lang;
  List<String> targetLanguagePhrases = [];


  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    lang = box.get("Lang")[n.toString()]["Selected_lang"];

    // log(box.get("Lang").toString());

    if (lang[0] == 'German') {
      // Populate sentences with German content
      targetLanguagePhrases =[
        "Guten Morgen",
        "Wie geht es dir?",
        "Wo wohnst du?",
        "Wie heißt du?",
        "Wie viel kostet das?",
      ];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      targetLanguagePhrases =  [
        "Bonjour",
        "Comment ça va?",
        "Où habitez-vous?",
        "Comment vous appelez-vous?",
        "Combien ça coûte?",
      ];
    } else if(lang[0]=='Russian'){
      targetLanguagePhrases = [
        "Здравствуйте",
        "Как дела?",
        "Где вы живете?",
        "Как вас зовут?",
        "Сколько это стоит?",
      ];
    }
    else if(lang[0]=='Japanese'){
      targetLanguagePhrases = [
        "こんにちは",
        "元気ですか？",
        "どこに住んでいますか？",
        "お名前は何ですか？",
        "いくらですか？",
      ];
    }
    else if(lang[0]=='Korean'){
      targetLanguagePhrases= [
        "안녕하세요",
        "어떻게 지내세요?",
        "어디에 살고 있습니까?",
        "당신의 이름은 무엇입니까?",
        "얼마입니까?",
      ];
    }
    else if(lang[0]=='Malayalam'){
      targetLanguagePhrases=[
        "നമസ്കാരം",
        "സുഖമാണോ?",
        "എങ്ങനെ നിങ്ങൾ താഴെ നിന്നും വസിക്കുന്നു?",
        "നിങ്ങളുടെ പേര് എന്താണ്?",
        "എവിടെ നിന്നും വന്നത് എന്താണ്?",
      ];
    }
    else if(lang[0]=='Tamil'){
      targetLanguagePhrases=  [
        "வணக்கம்",
        "நீங்கள் எப்படி உள்ளீர்கள்?",
        "நீங்கள் எங்கே வசிக்கின்றீர்கள்?",
        "உங்கள் பெயர் என்ன?",
        "எங்கே நீங்கள் வந்துவிட்டீர்கள்?",
      ];
    }
    else{
      targetLanguagePhrases=[
        "नमस्ते",
        "आप कैसे हैं?",
        "आप कहाँ रहते हैं?",
        "आपका नाम क्या है?",
        "आप कहाँ से आए हैं?",
      ];
    }

  }

  List<String> nativeLanguageTranslations = [
    "Hello",
    "How are you?",
    "Where do you live?",
    "What is your name?",
    "How much does it cost?",
  ];

  List<int> matchedIndices = [];

  void _onTap(int index) {
    setState(() {
      if (matchedIndices.contains(index)) {
        matchedIndices.remove(index);
      } else {
        matchedIndices.add(index);
      }

      if (matchedIndices.length == targetLanguagePhrases.length) {
        // All phrases have been matched
        _showDialog("Congratulations!", "You have completed the game.");
      }
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phrase Matching Game'),
      ),
      body: ListView.builder(
        itemCount: targetLanguagePhrases.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTap(index),
            child: Card(
              child: ListTile(
                title: Text(targetLanguagePhrases[index]),
                subtitle: matchedIndices.contains(index)
                    ? Text(nativeLanguageTranslations[index], style: TextStyle(fontWeight: FontWeight.bold))
                    : Text('Tap to reveal translation'),
              ),
            ),
          );
        },
      ),
    );
  }
}
