import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Alphabetsokay extends StatefulWidget {
  const Alphabetsokay();

  @override
  State<Alphabetsokay> createState() => _AlphabetsokayState();
}

class _AlphabetsokayState extends State<Alphabetsokay> {
  late var lang;

  List<String> Alphabets = [];

  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    lang = box.get("Lang")[n.toString()]["Selected_lang"];

    // log(box.get("Lang").toString());

    if (lang[0] == 'German') {
      // Populate sentences with German content
      Alphabets =[
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        'ä', 'ö', 'ü', 'ß' // German special characters
      ];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      Alphabets =  [
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        'à', 'â', 'ç', 'é', 'è', 'ê', 'ë', 'î', 'ï', 'ô', 'œ', 'ù', 'û', 'ü' // French special characters
      ];
    } else if(lang[0]=='Russian'){
      Alphabets =[
        'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м',
        'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ',
        'ы', 'ь', 'э', 'ю', 'я' // Russian letters
      ];
    }
    else if(lang[0]=='Japanese'){
      Alphabets = [
        'あ', 'い', 'う', 'え', 'お',
        'か', 'き', 'く', 'け', 'こ',
        'さ', 'し', 'す', 'せ', 'そ',
        'た', 'ち', 'つ', 'て', 'と',
        'な', 'に', 'ぬ', 'ね', 'の',
        'は', 'ひ', 'ふ', 'へ', 'ほ',
        'ま', 'み', 'む', 'め', 'も',
        'や', 'ゆ', 'よ',
        'ら', 'り', 'る', 'れ', 'ろ',
        'わ', 'を', 'ん',
      ];

    }
    else if(lang[0]=='Korean'){
      Alphabets= [
        'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ',
        'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ',
        'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
        'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ', 'ㅏ',
        'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ',
        'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ',
        'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ',
        'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ'
      ];
    }
    else if(lang[0]=='Malayalam'){
      Alphabets=[
        'അ', 'ആ', 'ഇ', 'ഈ', 'ഉ',
        'ഊ', 'ഋ', 'എ', 'ഏ', 'ഐ',
        'ഒ', 'ഓ', 'ഔ', 'ക', 'ഖ',
        'ഗ', 'ഘ', 'ങ', 'ച', 'ഛ',
        'ജ', 'ഝ', 'ഞ', 'ട', 'ഠ',
        'ഡ', 'ഢ', 'ണ', 'ത', 'ഥ',
        'ദ', 'ധ', 'ന', 'പ', 'ഫ',
        'ബ', 'ഭ', 'മ', 'യ', 'ര',
        'ല', 'വ', 'ശ', 'ഷ', 'സ',
        'ഹ', 'ള', 'ഴ', 'റ', 'ഴ'
      ];
    }
    else if(lang[0]=='Tamil'){
      Alphabets= [
        'அ', 'ஆ', 'இ', 'ஈ', 'உ',
        'ஊ', 'எ', 'ஏ', 'ஐ', 'ஒ',
        'ஓ', 'ஔ', 'க', 'ங', 'ச',
        'ஞ', 'ட', 'ண', 'த', 'ந',
        'ப', 'ம', 'ய', 'ர', 'ல',
        'வ', 'ழ', 'ள', 'ற', 'ன'
      ];
    }
    else{
      Alphabets = [
        'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ए', 'ऐ', 'ओ', 'औ',
        'क', 'ख', 'ग', 'घ', 'ङ',
        'च', 'छ', 'ज', 'झ', 'ञ',
        'ट', 'ठ', 'ड', 'ढ', 'ण',
        'त', 'थ', 'द', 'ध', 'न',
        'प', 'फ', 'ब', 'भ', 'म',
        'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह',
        'क्ष', 'त्र', 'ज्ञ',
      ];
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabets'),
      ),
      body: ListView.builder(
        itemCount: Alphabets.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Center(
                child: Text(
                  Alphabets[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
