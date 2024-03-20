import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Vocabularyokay extends StatefulWidget {
  const Vocabularyokay({Key? key}) : super(key: key);

  @override
  _VocabularyokayState createState() => _VocabularyokayState();
}

class _VocabularyokayState extends State<Vocabularyokay> {
  late var lang;

  List<Map<String, dynamic>> Alphabets = [];
  List<String> germanTranslations = [];
  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    lang = box.get("Lang")[n.toString()]["Selected_lang"];
    startGame();
    textEditingController = TextEditingController();
    message = '';
    // log(box.get("Lang").toString());

    if (lang[0] == 'German') {
      germanTranslations=[
        'Apfel',
        'Banane',
        'Katze',
        'Hund',
        'Elefant',
        'Blume',
        'Gitarre',
        'Haus',
        'Eiscreme',
        'Jacke',
      ];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      germanTranslations =  [
        'pomme',
        'banane',
        'chat',
        'chien',
        'éléphant',
        'fleur',
        'guitare',
        'maison',
        'crème glacée',
        'veste'
      ];
    } else if(lang[0]=='Russian'){
      germanTranslations = [
        'яблоко',
        'банан',
        'кот',
        'собака',
        'слон',
        'цветок',
        'гитара',
        'дом',
        'мороженое',
        'куртка'
      ];
    }
    else if(lang[0]=='Japanese'){
      germanTranslations = [
        'りんご (ringo)',
        'バナナ (banana)',
        '猫 (neko)',
        '犬 (inu)',
        '象 (zō)',
        '花 (hana)',
        'ギター (gitā)',
        '家 (ie)',
        'アイスクリーム (aisu kurīmu)',
        'ジャケット (jaketto)'
      ];
    }
    else if(lang[0]=='Korean'){
      germanTranslations= [
        '사과 (sagwa)',
        '바나나 (banana)',
        '고양이 (goyangi)',
        '개 (gae)',
        '코끼리 (kokkiri)',
        '꽃 (kkot)',
        '기타 (gita)',
        '집 (jib)',
        '아이스크림 (aiseukeurim)',
        '재킷 (jaekit)'
      ];
    }
    else if(lang[0]=='Malayalam'){
      germanTranslations=[
        'ആപ്പിൾ (āppil)',
        'പഴം (paḻaṁ)',
        'പൂച്ച (pūcca)',
        'നായ (nāya)',
        'ആന (āna)',
        'പൂ (pū)',
        'ഗിറ്റാർ (girṭār)',
        'വീട് (vīṭ)',
        'ഐസ്ക്രീം (aiskrīṁ)',
        'ജാക്കറ്റ് (jākkarṭ)'
      ];
    }
    else if(lang[0]=='Tamil'){
      germanTranslations= [
        'ஆப்பிள் (āppiḷ)',
        'வாழைப்பழம் (vāḻaippaḻam)',
        'பூனை (pūnai)',
        'நாய் (nāy)',
        'யானை (yāṉai)',
        'மலர் (malar)',
        'கிட்டார் (kiṭṭār)',
        'வீடு (vīṭu)',
        'ஐஸ்கிரீம் (aiskirīm)',
        'ஜாக்கெட் (jākkeṭ)'
      ];
    }
    else{
      germanTranslations=[
        'सेब',
        'केला',
        'बिल्ली',
        'कुत्ता',
        'हाथी',
        'फूल',
        'गिटार',
        'घर',
        'आइसक्रीम',
        'जैकेट',
      ];
    }

  }
  List<String> englishVocabulary = [
    'apple',
    'banana',
    'cat',
    'dog',
    'elephant',
    'flower',
    'guitar',
    'house',
    'ice cream',
    'jacket',
  ];


  late String currentWord;
  late TextEditingController textEditingController;
  late String message;



  void startGame() {
    setState(() {
      currentWord = englishVocabulary[0];
    });
  }

  void checkAnswer() {
    setState(() {
      String userAnswer = textEditingController.text.toLowerCase();
      int index = englishVocabulary.indexOf(currentWord);
      if (index != -1 && germanTranslations[index].toLowerCase() == userAnswer) {
        message = 'Correct!';
      } else {
        message = 'Wrong!';
      }
      textEditingController.clear();
    });
  }

  void nextWord() {
    int index = englishVocabulary.indexOf(currentWord);
    if (index < englishVocabulary.length - 1) {
      setState(() {
        currentWord = englishVocabulary[index + 1];
        message = '';
      });
    } else {
      // End of game
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have completed the vocabulary game.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What is the ${lang[0]}  word for:",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10),
            Text(
              currentWord,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                checkAnswer();
              },
              child: Text('Check Answer'),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(
                color: message == 'Correct!' ? Colors.green : Colors.red,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                nextWord();
              },
              child: Text('Next Word'),
            ),
          ],
        ),
      ),
    );
  }
}