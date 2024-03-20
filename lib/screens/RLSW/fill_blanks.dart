

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LanguageLearningPage extends StatefulWidget {
   final User user;

  const LanguageLearningPage({Key? key, required this.user}) : super(key: key);
  @override
  _LanguageLearningPageState createState() => _LanguageLearningPageState();

}

class _LanguageLearningPageState extends State<LanguageLearningPage> {
  static FirebaseFirestore firestore=FirebaseFirestore.instance;

  late User _currentUser;
  late var lang;

  List<Map<String, dynamic>> sentences = [];

  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    lang = box.get("Lang")[n.toString()]["Selected_lang"];

    // log(box.get("Lang").toString());

    if (lang[0] == 'German') {
      // Populate sentences with German content
      sentences = [
        {"sentence": "Er ____ seinen Hund aus.", "correctWord": "führt", "options": ["führt", "führen", "führst"]},
  {
        'image': 'assets/lis.png',
        'correctWord': 'Kopfhörer',
        'options': ['Kopfhörer', 'Telefon', 'Computer'],
      },
        {"sentence": "Sie ____ im Park spazieren.", "correctWord": "geht", "options": ["geht", "gehen", "gehst"]},
        {"sentence": "Ich ____ mit meinen Freunden Fußball.", "correctWord": "spiele", "options": ["spiele", "spielen", "spielst"]},
          {
            'image': 'assets/apple.jpg',
            'correctWord': 'Apfel',
            'options': ['Apfel', 'Weintrauben', 'mango'],
          },
        {"sentence": "Wir ____ am Wochenende ins Kino.", "correctWord": "gehen", "options": ["gehen", "geht", "gehts"]},
        {"sentence": "Du ____ gerne in der Natur.", "correctWord": "wanderst", "options": ["wanderst", "wandern", "wandere"]},
  {
        'image': 'assets/cat.jpg',
        'correctWord': 'Katze',
        'options': ['Katze', 'hund', 'Löwe'],
      },
        {"sentence": "Sie ____ oft im Garten.", "correctWord": "arbeitet", "options": ["arbeitet", "arbeiten", "arbeitest"]},
        {"sentence": "Der Lehrer ____ die Schüler in der Klasse.", "correctWord": "unterrichtet", "options": ["unterrichtet", "unterrichten", "unterrichtest"]},
  {
        'image': 'assets/laptop.jpg',
        'correctWord': 'laptop',
        'options': ['laptop', 'Mobiltelefon', 'Messung'],
      },
        {"sentence": "Die Katze ____ im Haus herum.", "correctWord": "läuft", "options": ["läuft", "laufen", "läufst"]},
        {"sentence": "Er ____ sein Fahrrad zur Arbeit.", "correctWord": "fährt", "options": ["fährt", "fahren", "fährst"]},
          {
            'image': 'assets/tree.jpg',
            'correctWord': 'Baum',
            'options': ['Baum', 'Tisch', 'Computer'],
          },
        {"sentence": "Sie ____ regelmäßig im Fitnessstudio.", "correctWord": "trainiert", "options": ["trainiert", "trainieren", "trainierst"]},
        {"sentence": "Die Kinder ____ im Garten Ball.", "correctWord": "spielen", "options": ["spielen", "spielst", "spielt"]},
        {"sentence": "Sie ____ in der Bibliothek.", "correctWord": "studiert", "options": ["studiert", "studieren", "studierst"]},
        {"sentence": "Wir ____ morgen zum Strand.", "correctWord": "fahren", "options": ["fahren", "fährt", "fahrt"]},
        {"sentence": "Ich ____ gern Comics.", "correctWord": "lese", "options": ["lese", "liest", "lesen"]},
        {"sentence": "Du ____ auf dem Sofa.", "correctWord": "liegst", "options": ["liegst", "liegen", "liegt"]},
        {"sentence": "Sie ____ im Restaurant.", "correctWord": "isst", "options": ["isst", "essen", "isst"]},
        {"sentence": "Er ____ in der Küche.", "correctWord": "kocht", "options": ["kocht", "kochen", "kochst"]},
        {"sentence": "Sie ____ im Park Fahrrad.", "correctWord": "fährt", "options": ["fährt", "fahren", "fahrt"]},
        {"sentence": "Wir ____ im Garten.", "correctWord": "arbeiten", "options": ["arbeiten", "arbeitet", "arbeitest"]},
        {"sentence": "Der Lehrer ____ die Frage.", "correctWord": "beantwortet", "options": ["beantwortet", "beantworten", "beantwortest"]},
        {"sentence": "Die Katze ____ auf dem Sofa.", "correctWord": "schläft", "options": ["schläft", "schlafen", "schläfst"]},
        {"sentence": "Er ____ am Computer.", "correctWord": "arbeitet", "options": ["arbeitet", "arbeitest", "arbeiten"]},

      ];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      sentences = [
        {"sentence": "Il ____ un cadeau.", "correctWord": "achète", "options": ["achète", "acheter", "achetons"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'écouteurs',
          'options': ['écouteurs', 'téléphone', 'ordinateur'],
        },
        {"sentence": "Elle ____ un café.", "correctWord": "boit", "options": ["boit", "boire", "bois"]},
        {"sentence": "Nous ____ au marché.", "correctWord": "allons", "options": ["allons", "aller", "allez"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': 'Pomme',
          'options': ['Pomme', 'Raisins', 'mangue'],
        },
        {"sentence": "Ils ____ au travail.", "correctWord": "vont", "options": ["vont", "aller", "va"]},
        {"sentence": "Tu ____ la voiture.", "correctWord": "conduis", "options": ["conduis", "conduire", "conduits"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': 'Chat',
          'options': ['Chat', 'chien', 'Lion'],
        },
        {"sentence": "Elle ____ un livre.", "correctWord": "lit", "options": ["lit", "lire", "lis"]},
        {"sentence": "Je ____ un gâteau.", "correctWord": "mange", "options": ["mange", "manger", "manges"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': 'Ordinateur portable',
          'options': ['Ordinateur portable', 'Mobile', 'Mesure'],
        },
        {"sentence": "Il ____ une chanson.", "correctWord": "chante", "options": ["chante", "chanter", "chantes"]},
        {"sentence": "Elle ____ une lettre.", "correctWord": "écrit", "options": ["écrit", "écrire", "écris"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': 'Arbre',
          'options': ['Arbre', 'Table', 'Ordinateur'],
        },
        {"sentence": "Nous ____ un film.", "correctWord": "regardons", "options": ["regardons", "regarder", "regardez"]},
        {"sentence": "Ils ____ une pizza.", "correctWord": "mangent", "options": ["mangent", "manger", "mangeons"]},
        {"sentence": "Tu ____ un livre.", "correctWord": "lis", "options": ["lis", "lire", "lit"]},
        {"sentence": "Il ____ un vélo.", "correctWord": "roule", "options": ["roule", "rouler", "roules"]},
        {"sentence": "Elle ____ un match.", "correctWord": "regarde", "options": ["regarde", "regarder", "regardes"]},
        {"sentence": "Nous ____ du pain.", "correctWord": "achetons", "options": ["achetons", "acheter", "achète"]},
        {"sentence": "Ils ____ un livre.", "correctWord": "lisent", "options": ["lisent", "lire", "lit"]},
        {"sentence": "Tu ____ une chanson.", "correctWord": "chantes", "options": ["chantes", "chanter", "chante"]},
        {"sentence": "Il ____ un dessin.", "correctWord": "dessine", "options": ["dessine", "dessiner", "dessines"]},
        {"sentence": "Elle ____ une photo.", "correctWord": "prend", "options": ["prend", "prendre", "prends"]},
        {"sentence": "Nous ____ une promenade.", "correctWord": "faisons", "options": ["faisons", "faire", "faites"]},
        {"sentence": "Ils ____ une erreur.", "correctWord": "font", "options": ["font", "faire", "faisons"]},
        {"sentence": "Tu ____ une pâtisserie.", "correctWord": "dégustes", "options": ["dégustes", "déguster", "déguste"]},
        {"sentence": "Il ____ une fête.", "correctWord": "organise", "options": ["organise", "organiser", "organises"]},
        {"sentence": "Elle ____ une surprise.", "correctWord": "prépare", "options": ["prépare", "préparer", "prépares"]},
      ];
    } else if(lang[0]=='Russian'){
      sentences = [
        {"sentence": "Он ____ свою собаку.", "correctWord": "гуляет", "options": ["гуляет", "гулять", "гуляешь"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'наушники',
          'options': ['наушники', 'телефон', 'компьютер'],
        },
        {"sentence": "Она ____ книгу.", "correctWord": "читает", "options": ["читает", "читать", "читаешь"]},
        {"sentence": "Мы ____ фильм.", "correctWord": "смотрим", "options": ["смотрим", "смотреть", "смотрите"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': 'Яблоко',
          'options': ['Яблоко', 'Виноград', 'Манго'],
        },
        {"sentence": "Вы ____ домой.", "correctWord": "идете", "options": ["идете", "идти", "идешь"]},
        {"sentence": "Ты ____ письмо.", "correctWord": "писал", "options": ["писал", "писать", "пишешь"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': 'Кошка',
          'options': ['Кошка', 'Собака', 'Лев'],
        },
        {"sentence": "Он ____ работу.", "correctWord": "ищет", "options": ["ищет", "искать", "ищешь"]},
        {"sentence": "Она ____ деньги.", "correctWord": "зарабатывает", "options": ["зарабатывает", "зарабатывать", "зарабатываешь"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': 'Ноутбук',
          'options': ['Ноутбук', 'Мобильный', 'Измерение'],
        },
        {"sentence": "Мы ____ домой.", "correctWord": "едем", "options": ["едем", "ехать", "едешь"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': 'Дерево',
          'options': ['Дерево', 'Стол', 'Компьютер'],
        },
        {"sentence": "Они ____ футбол.", "correctWord": "играют", "options": ["играют", "играть", "играешь"]},
        {"sentence": "Я ____ карандаш.", "correctWord": "рисую", "options": ["рисую", "рисовать", "рисуешь"]},
        {"sentence": "Он ____ в школе.", "correctWord": "учится", "options": ["учится", "учиться", "учишься"]},
        {"sentence": "Она ____ яблоко.", "correctWord": "едит", "options": ["едит", "есть", "ест"]},
        {"sentence": "Мы ____ домой.", "correctWord": "приходим", "options": ["приходим", "приходить", "приходите"]},
        {"sentence": "Вы ____ в парк.", "correctWord": "идете", "options": ["идете", "идти", "идешь"]},
        {"sentence": "Ты ____ в магазин.", "correctWord": "идешь", "options": ["идешь", "идти", "идете"]},
        {"sentence": "Он ____ домой.", "correctWord": "возвращается", "options": ["возвращается", "возвращаться", "возвращаешься"]},
        {"sentence": "Она ____ вечером.", "correctWord": "засыпает", "options": ["засыпает", "засыпать", "засыпаешь"]},
        {"sentence": "Мы ____ вечером.", "correctWord": "спим", "options": ["спим", "спать", "спите"]},
        {"sentence": "Они ____ уроки.", "correctWord": "учатся", "options": ["учатся", "учиться", "учишься"]},
        {"sentence": "Я ____ на работе.", "correctWord": "работаю", "options": ["работаю", "работать", "работаете"]},
        {"sentence": "Он ____ с друзьями.", "correctWord": "общается", "options": ["общается", "общаться", "общаешься"]},
        {"sentence": "Она ____ книгу.", "correctWord": "читает", "options": ["читает", "читать", "читаешь"]},
        {"sentence": "Мы ____ домой.", "correctWord": "едем", "options": ["едем", "ехать", "едешь"]},
      ];
    }
    else if(lang[0]=='Japanese'){
      sentences = [
        {"sentence": "彼は ____ 犬を散歩しています。", "correctWord": "散歩しています", "options": ["散歩しています", "散歩します", "散歩して"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'ヘッドホン',
          'options': ['ヘッドホン', ' 電話 (でんわ', 'パソコン'],
        },
        {"sentence": "彼女は ____ 本を読んでいます。", "correctWord": "読んでいます", "options": ["読んでいます", "読みます", "読んで"]},
        {"sentence": "私たちは ____ 映画を見ています。", "correctWord": "見ています", "options": ["見ています", "見ます", "見て"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': 'りんご',
          'options': ['りんご', 'ぶどう', 'マンゴー'],
        },
        {"sentence": "あなたは ____ 家に帰っています。", "correctWord": "帰っています", "options": ["帰っています", "帰ります", "帰って"]},
        {"sentence": "彼は ____ 手紙を書いています。", "correctWord": "書いています", "options": ["書いています", "書きます", "書いて"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': 'ネコ',
          'options': ['ネコ', '犬', 'ライオン'],
        },
        {"sentence": "彼は ____ 仕事を探しています。", "correctWord": "探しています", "options": ["探しています", "探します", "探して"]},
        {"sentence": "彼女は ____ お金を稼いでいます。", "correctWord": "稼いでいます", "options": ["稼いでいます", "稼ぎます", "稼いで"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': ' ノートパソコン',
          'options': [' ノートパソコン', ' 携帯電話', '測定'],
        },
        {"sentence": "私たちは ____ 家に向かっています。", "correctWord": "向かっています", "options": ["向かっています", "向かいます", "向かって"]},
        {"sentence": "彼らは ____ サッカーをしています。", "correctWord": "しています", "options": ["しています", "します", "して"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': '木 (き',
          'options': ['木 (き', 'テーブル', 'パソコン'],
        },
        {"sentence": "私は ____ ペンを描いています。", "correctWord": "描いています", "options": ["描いています", "描きます", "描いて"]},
        {"sentence": "彼は ____ 学校で勉強しています。", "correctWord": "勉強しています", "options": ["勉強しています", "勉強します", "勉強して"]},
        {"sentence": "彼女は ____ りんごを食べています。", "correctWord": "食べています", "options": ["食べています", "食べます", "食べて"]},
        {"sentence": "私たちは ____ 家に帰っています。", "correctWord": "帰っています", "options": ["帰っています", "帰ります", "帰って"]},
        {"sentence": "あなたは ____ 公園に行っています。", "correctWord": "行っています", "options": ["行っています", "行きます", "行って"]},
        {"sentence": "あなたは ____ 公園に行っていますか？", "correctWord": "行っていますか", "options": ["行っていますか", "行きますか", "行ってか"]},
        {"sentence": "彼は ____ 家に戻っています。", "correctWord": "戻っています", "options": ["戻っています", "戻ります", "戻って"]},
        {"sentence": "彼女は ____ 夕方に眠りに落ちています。", "correctWord": "眠りに落ちています", "options": ["眠りに落ちています", "眠っています", "眠りに落ちて"]},
        {"sentence": "私たちは ____ 夜眠っています。", "correctWord": "眠っています", "options": ["眠っています", "眠ります", "眠って"]},
        {"sentence": "彼らは ____ レッスンを受けています。", "correctWord": "受けています", "options": ["受けています", "受けます", "受けて"]},
        {"sentence": "私は ____ 仕事で働いています。", "correctWord": "働いています", "options": ["働いています", "働きます", "働いて"]},
        {"sentence": "彼は ____ 友達と話しています。", "correctWord": "話しています", "options": ["話しています", "話します", "話して"]},
        {"sentence": "彼女は ____ 本を読んでいます。", "correctWord": "読んでいます", "options": ["読んでいます", "読みます", "読んで"]},
        {"sentence": "私たちは ____ 家に帰っています。", "correctWord": "帰っています", "options": ["帰っています", "帰ります", "帰って"]},
        {"sentence": "あなたは ____ 公園に行っています。", "correctWord": "行っています", "options": ["行っています", "行きます", "行って"]},
        {"sentence": "あなたは ____ 公園に行っていますか？", "correctWord": "行っていますか", "options": ["行っていますか", "行きますか", "行ってか"]},
        {"sentence": "彼は ____ 家に戻っています。", "correctWord": "戻っています", "options": ["戻っています", "戻ります", "戻って"]},
        {"sentence": "彼女は ____ 夕方に眠りに落ちています。", "correctWord": "眠りに落ちています", "options": ["眠りに落ちています", "眠っています", "眠りに落ちて"]},
        {"sentence": "私たちは ____ 夜眠っています。", "correctWord": "眠っています", "options": ["眠っています", "眠ります", "眠って"]},
        {"sentence": "彼らは ____ レッスンを受けています。", "correctWord": "受けています", "options": ["受けています", "受けます", "受けて"]},
        {"sentence": "私は ____ 仕事で働いています。", "correctWord": "働いています", "options": ["働いています", "働きます", "働いて"]},
      ];
    }
    else if(lang[0]=='Korean'){
      sentences=[
  {"sentence": "그는 ____ 사과를 먹고 있어요.", "correctWord": "먹고 있어요", "options": ["먹고 있어요", "먹어요", "먹고"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'ヘッドホン',
          'options': ['ヘッドホン', ' 電話 (でんわ', 'パソコン'],
        },
  {"sentence": "그녀는 ____ 책을 읽고 있어요.", "correctWord": "읽고 있어요", "options": ["읽고 있어요", "읽어요", "읽고"]},
  {"sentence": "우리는 ____ 영화를 보고 있어요.", "correctWord": "보고 있어요", "options": ["보고 있어요", "봐요", "보고"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': '사과',
          'options': ['사과', '포도', '망고'],
        },
  {"sentence": "너는 ____ 집에 가고 있어요.", "correctWord": "가고 있어요", "options": ["가고 있어요", "가요", "가고"]},
  {"sentence": "그는 ____ 편지를 쓰고 있어요.", "correctWord": "쓰고 있어요", "options": ["쓰고 있어요", "써요", "쓰고"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': '고양이',
          'options': ['고양이', '개', '사자'],
        },
  {"sentence": "그는 ____ 일을 찾고 있어요.", "correctWord": "찾고 있어요", "options": ["찾고 있어요", "찾아요", "찾고"]},
  {"sentence": "그녀는 ____ 돈을 벌고 있어요.", "correctWord": "벌고 있어요", "options": ["벌고 있어요", "벌어요", "벌고"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': ' 노트북',
          'options': [' 노트북', ' 휴대 전화 ', '측정'],
        },
  {"sentence": "우리는 ____ 집으로 가고 있어요.", "correctWord": "가고 있어요", "options": ["가고 있어요", "가요", "가고"]},
  {"sentence": "그들은 ____ 축구를 하고 있어요.", "correctWord": "하고 있어요", "options": ["하고 있어요", "해요", "하고"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': '木 (き',
          'options': ['木 (き', 'テーブル', 'パソコン'],
        },
  {"sentence": "저는 ____ 펜을 그리고 있어요.", "correctWord": "그리고 있어요", "options": ["그리고 있어요", "그려요", "그리고"]},
  {"sentence": "그는 ____ 학교에서 공부하고 있어요.", "correctWord": "공부하고 있어요", "options": ["공부하고 있어요", "공부해요", "공부하고"]},
  {"sentence": "그녀는 ____ 사과를 먹고 있어요.", "correctWord": "먹고 있어요", "options": ["먹고 있어요", "먹어요", "먹고"]},
  {"sentence": "우리는 ____ 집으로 돌아가고 있어요.", "correctWord": "돌아가고 있어요", "options": ["돌아가고 있어요", "돌아가요", "돌아가고"]},
  {"sentence": "당신은 ____ 공원에 가고 있어요.", "correctWord": "가고 있어요", "options": ["가고 있어요", "가요", "가고"]},
  {"sentence": "당신은 ____ 공원에 가고 있어요?", "correctWord": "가고 있어요", "options": ["가고 있어요", "가요", "가고"]},
  {"sentence": "그는 ____ 집으로 돌아가고 있어요.", "correctWord": "돌아가고 있어요", "options": ["돌아가고 있어요", "돌아가요", "돌아가고"]},
  {"sentence": "그녀는 ____ 저녁에 잠에 빠지고 있어요.", "correctWord": "잠에 빠지고 있어요", "options": ["잠에 빠지고 있어요", "잠들어 있어요", "잠에 빠지고"]},
  {"sentence": "우리는 ____ 밤에 잠을 자고 있어요.", "correctWord": "잠을 자고 있어요", "options": ["잠을 자고 있어요", "잠을 자요", "잠을 자고"]},
  {"sentence": "그들은 ____ 수업을 받고 있어요.", "correctWord": "받고 있어요", "options": ["받고 있어요", "받아요", "받고"]},
  {"sentence": "저는 ____ 일을 하고 있어요.", "correctWord": "하고 있어요", "options": ["하고 있어요", "해요", "하고"]},
  {"sentence": "그는 ____ 친구와 이야기하고 있어요.", "correctWord": "이야기하고 있어요", "options": ["이야기하고 있어요", "이야기해요", "이야기하고"]},
  {"sentence": "그녀는 ____ 책을 읽고 있어요.", "correctWord": "읽고 있어요", "options": ["읽고 있어요", "읽어요", "읽고"]},
  {"sentence": "우리는 ____ 집으로 돌아가고 있어요.", "correctWord": "돌아가고 있어요", "options": ["돌아가고 있어요", "돌아가요", "돌아가고"]},
    ];
    }
    else if(lang[0]=='Malayalam'){
      sentences=[{"sentence": "അവൻ ____ കളിക്കുന്നു.", "correctWord": "കളിക്കുന്നു", "options": ["കളിക്കുന്നു", "കളിക്കുക", "കളിയുക"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'ヘッドホン',
          'options': ['ヘッドホン', ' 電話 (でんわ', 'パソコン'],
        },
        {"sentence": "അവൾ ____ പുസ്തകം വായിക്കുന്നു.", "correctWord": "വായിക്കുന്നു", "options": ["വായിക്കുന്നു", "വായിക്കുക", "വായിക്കുകയാണ്"]},
        {"sentence": "ഞാൻ ____ ചിത്രം കാണുന്നു.", "correctWord": "കാണുന്നു", "options": ["കാണുന്നു", "കാണാം", "കാണുക"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': '사과',
          'options': ['사과', '포도', '망고'],
        },
        {"sentence": "നിങ്ങൾ ____ ചായ കുടിക്കുന്നു.", "correctWord": "കുടിക്കുന്നു", "options": ["കുടിക്കുന്നു", "കുടിക്കുക", "കുടിക്കാം"]},
        {"sentence": "നിങ്ങൾ ____ അറിയുന്നു.", "correctWord": "അറിയുന്നു", "options": ["അറിയുന്നു", "അറിയിക്കുന്നു", "അറിയുക"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': 'ネコ',
          'options': ['ネコ', '犬', 'ライオン'],
        },
        {"sentence": "അവൻ ____ വനിതയുടെ സഹായം ആവശ്യപ്പെടുന്നു.", "correctWord": "ആവശ്യപ്പെടുന്നു", "options": ["ആവശ്യപ്പെടുന്നു", "ആവശ്യപ്പെടുക", "ആവശ്യപ്പെടാം"]},
        {"sentence": "അവൾ ____ മാത്രമേ ഉപയോഗിക്കുന്നു.", "correctWord": "ഉപയോഗിക്കുന്നു", "options": ["ഉപയോഗിക്കുന്നു", "ഉപയോഗിക്കുക", "ഉപയോഗിക്കാം"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': ' ノートパソコン',
          'options': [' ノートパソコン', ' 携帯電話', '測定'],
        },
        {"sentence": "അദ്ദേഹം ____ പുസ്തകം വായിച്ചു.", "correctWord": "വായിച്ചു", "options": ["വായിച്ചു", "വായിച്ചുണ്ട്", "വായിച്ചുകൊണ്ട്"]},
        {"sentence": "നിങ്ങൾ ____ അതിൽ ചേർന്നിരിക്കുന്നു.", "correctWord": "ചേർന്നിരിക്കുന്നു", "options": ["ചേർന്നിരിക്കുന്നു", "ചേർന്നു", "ചേർന്നുണ്ട്"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': '木 (き',
          'options': ['木 (き', 'テーブル', 'パソコン'],
        },
        {"sentence": "അത് ____ വിദ്യാഭ്യാസം നൽകുന്നു.", "correctWord": "നൽകുന്നു", "options": ["നൽകുന്നു", "നൽകുക", "നൽകുകയാണ്"]},
        {"sentence": "അത് ____ വിദ്യാഭ്യാസം നൽകുന്നു.", "correctWord": "നൽകുന്നു", "options": ["നൽകുന്നു", "നൽകുക", "നൽകുകയാണ്"]},
        {"sentence": "നിങ്ങൾ ____ ചിത്രം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},
        {"sentence": "നിങ്ങൾ ____ പുസ്തകം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},
        {"sentence": "നിങ്ങൾ ____ പുസ്തകം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},
        {"sentence": "നിങ്ങൾ ____ പുസ്തകം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},
        {"sentence": "അദ്ദേഹം ____ പുസ്തകം വായിച്ചു.", "correctWord": "വായിച്ചു", "options": ["വായിച്ചു", "വായിച്ചുണ്ട്", "വായിച്ചുകൊണ്ട്"]},
        {"sentence": "അത് ____ വിദ്യാഭ്യാസം നൽകുന്നു.", "correctWord": "നൽകുന്നു", "options": ["നൽകുന്നു", "നൽകുക", "നൽകുകയാണ്"]},
        {"sentence": "അത് ____ വിദ്യാഭ്യാസം നൽകുന്നു.", "correctWord": "നൽകുന്നു", "options": ["നൽകുന്നു", "നൽകുക", "നൽകുകയാണ്"]},
        {"sentence": "നിങ്ങൾ ____ ചിത്രം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},
        {"sentence": "അദ്ദേഹം ____ പുസ്തകം വായിച്ചു.", "correctWord": "വായിച്ചു", "options": ["വായിച്ചു", "വായിച്ചുണ്ട്", "വായിച്ചുകൊണ്ട്"]},
        {"sentence": "അദ്ദേഹം ____ പുസ്തകം വായിച്ചു.", "correctWord": "വായിച്ചു", "options": ["വായിച്ചു", "വായിച്ചുണ്ട്", "വായിച്ചുകൊണ്ട്"]},
        {"sentence": "നിങ്ങൾ ____ ചിത്രം വാങ്ങിയിരിക്കുന്നു.", "correctWord": "വാങ്ങിയിരിക്കുന്നു", "options": ["വാങ്ങിയിരിക്കുന്നു", "വാങ്ങിയിരിക്കുന്നുണ്ട്", "വാങ്ങിയിരിക്കുന്നുകൊണ്ട്"]},];
    }
    else if(lang[0]=='Tamil'){
      sentences= [
  {"sentence": "அவர் ____ பாடுகின்றார்.", "correctWord": "பாடுகின்றார்", "options": ["பாடுகின்றார்", "பாடுகிறார்", "பாடுகிற"]},
        {
          'image': 'assets/lis.png',
          'correctWord': 'ヘッドホン',
          'options': ['ヘッドホン', ' 電話 (でんわ', 'パソコン'],
        },
  {"sentence": "அவர்கள் ____ விளையாடுகின்றனர்.", "correctWord": "விளையாடுகின்றனர்", "options": ["விளையாடுகின்றனர்", "விளையாடுகிறனர்", "விளையாடுகிற"]},
  {"sentence": "அவர் ____ வணிகன்.", "correctWord": "வணிகன்", "options": ["வணிகன்", "வணிக", "வணிகர்"]},
        {
          'image': 'assets/apple.jpg',
          'correctWord': '사과',
          'options': ['사과', '포도', '망고'],
        },
  {"sentence": "அவர் ____ உணவு செய்கின்றார்.", "correctWord": "உணவு செய்கின்றார்", "options": ["உணவு செய்கின்றார்", "உணவு செய்கிறார்", "உணவு செய்கிற"]},
  {"sentence": "அவர் ____ வாழ்க்கை நடத்தினார்.", "correctWord": "வாழ்க்கை நடத்தினார்", "options": ["வாழ்க்கை நடத்தினார்", "வாழ்க்கை நடத்துகின்றார்", "வாழ்க்கை நடத்துகிற"]},
        {
          'image': 'assets/cat.jpg',
          'correctWord': '고양이',
          'options': ['고양이', '개', '사자'],
        },
  {"sentence": "அவர் ____ முதலீடு செய்கின்றார்.", "correctWord": "முதலீடு செய்கின்றார்", "options": ["முதலீடு செய்கின்றார்", "முதலீடு செய்கிறார்", "முதலீடு செய்கிற"]},
  {"sentence": "அவர் ____ கல்வி பெறுகின்றார்.", "correctWord": "கல்வி பெறுகின்றார்", "options": ["கல்வி பெறுகின்றார்", "கல்வி பெறுகிறார்", "கல்வி பெறுகிற"]},
        {
          'image': 'assets/laptop.jpg',
          'correctWord': ' 노트북',
          'options': [' 노트북', ' 휴대 전화 ', '측정'],
        },
  {"sentence": "அவர் ____ மேலாளர்.", "correctWord": "மேலாளர்", "options": ["மேலாளர்", "மேலாளன்", "மேலாளர"]},
  {"sentence": "அவர் ____ மாணவர்.", "correctWord": "மாணவர்", "options": ["மாணவர்", "மாணவன்", "மாணவர"]},
        {
          'image': 'assets/tree.jpg',
          'correctWord': '木 (き',
          'options': ['木 (き', 'テーブル', 'パソコン'],
        },
  {"sentence": "அவர் ____ சொந்தமான வீடு உடையவர்.", "correctWord": "சொந்தமான வீடு உடையவர்", "options": ["சொந்தமான வீடு உடையவர்", "சொந்தமான வீடு உடையவன்", "சொந்தமான வீடு உடையவர"]},
  {"sentence": "அவர் ____ வாழ்க்கை பகிரப்பட்டுள்ளார்.", "correctWord": "வாழ்க்கை பகிரப்பட்டுள்ளார்", "options": ["வாழ்க்கை பகிரப்பட்டுள்ளார்", "வாழ்க்கை பகிரப்படும்", "வாழ்க்கை பகிரப்படுகிற"]},
  {"sentence": "அவர் ____ தொழிலாளி.", "correctWord": "தொழிலாளி", "options": ["தொழிலாளி", "தொழிலாளர்", "தொழிலாளியர்"]},
  {"sentence": "அவர் ____ சகல புகழ்.", "correctWord": "சகல புகழ்", "options": ["சகல புகழ்", "சகல புகழம்", "சகல புகழர்"]},
  {"sentence": "அவர் ____ மனிதன்.", "correctWord": "மனிதன்", "options": ["மனிதன்", "மனித", "மனிதர்"]},
  {"sentence": "அவர் ____ பணி செய்கின்றார்.", "correctWord": "பணி செய்கின்றார்", "options": ["பணி செய்கின்றார்", "பணி செய்கிறார்", "பணி செய்கிற"]},
  {"sentence": "அவர் ____ சிறு பணி செய்கின்றார்.", "correctWord": "சிறு பணி செய்கின்றார்", "options": ["சிறு பணி செய்கின்றார்", "சிறு பணி செய்கிறார்", "சிறு பணி செய்கிற"]},
  {"sentence": "அவர் ____ வாழ்க்கை காண்கின்றார்.", "correctWord": "வாழ்க்கை காண்கின்றார்", "options": ["வாழ்க்கை காண்கின்றார்", "வாழ்க்கை காண்கிறார்", "வாழ்க்கை காண்கிற"]},
  {"sentence": "அவர் ____ தமிழ்ப் புத்தகம் வாசிக்கின்றார்.", "correctWord": "தமிழ்ப் புத்தகம் வாசிக்கின்றார்", "options": ["தமிழ்ப் புத்தகம் வாசிக்கின்றார்", "தமிழ்ப் புத்தகம் வாசிக்கிறார்", "தமிழ்ப் புத்தகம் வாசிக்கிற"]},
  {"sentence": "அவர் ____ பயிற்சி செய்கின்றார்.", "correctWord": "பயிற்சி செய்கின்றார்", "options": ["பயிற்சி செய்கின்றார்", "பயிற்சி செய்கிறார்", "பயிற்சி செய்கிற"]},
  {"sentence": "அவர் ____ தொடர்பு கொள்ளுகின்றார்.", "correctWord": "தொடர்பு கொள்ளுகின்றார்", "options": ["தொடர்பு கொள்ளுகின்றார்", "தொடர்பு கொள்ளுகிறார்", "தொடர்பு கொள்ளுகிற"]},

      ];
    }
    else{
      sentences=[
        {
          "sentence": "अनिल ____ स्कूल जाता है।",
          "correctWord": "स्कूल",
          "options": ["खेल", "खाना", "स्कूल", "बाजार"],
        },
        {
          "sentence": "राम ____ काम करता है।",
          "correctWord": "काम",
          "options": ["खेल", "स्कूल", "काम", "बाजार"],
        },
  {
        'image': 'assets/lis.png',
        'correctWord': 'हेडफ़ोन',
        'options': ['हेडफ़ोन', 'फ़ोन', 'कंप्यूटर'],
      },
        {
          "sentence": "मेरी माँ ____ खाना बनाती है।",
          "correctWord": "खाना",
          "options": ["खेल", "काम", "खाना", "बाजार"],
        },
        {
          "sentence": "वह ____ बाजार जाता है।",
          "correctWord": "बाजार",
          "options": ["खेल", "काम", "स्कूल", "बाजार"],
        },
  {
        'image': 'assets/apple.jpg',
        'correctWord': 'सेब',
        'options': ['सेब', 'अंगूर ', 'आम'],
      },
        {
          "sentence": "अच्छा लड़का ____ स्कूल जाता है।",
          "correctWord": "स्कूल",
          "options": ["स्कूल", "काम", "खाना", "बाजार"],
        },
        {
          "sentence": "तुम ____ खेलते हो।",
          "correctWord": "खेलते",
          "options": ["स्कूल", "काम", "खेलते", "बाजार"],
        },
  {
        'image': 'assets/cat.jpg',
        'correctWord': 'बिल्ली',
        'options': ['बिल्ली', 'कुत्ता', 'शेर'],
      },
        {
          "sentence": "उसने ____ फल खाए।",
          "correctWord": "फल",
          "options": ["फल", "वस्त्र", "खाना", "स्कूल"],
        },
        {
          "sentence": "मैं ____ गाता हूँ।",
          "correctWord": "गाता",
          "options": ["फल", "वस्त्र", "गाता", "स्कूल"],
        },
          {
            'image': 'assets/laptop.jpg',
            'correctWord': ' लैपटॉप',
            'options': ['लैपटॉप', 'मोबाइल', 'मापन'],
          },
        {
          "sentence": "राम और श्याम ____ खेलते हैं।",
          "correctWord": "खेलते",
          "options": ["फल", "वस्त्र", "गाते", "खेलते"],
        },
        {
          "sentence": "तुम्हारे पिताजी ____ काम करते हैं।",
          "correctWord": "काम",
          "options": ["फल", "काम", "गाते", "खेलते"],
        },
          {
            'image': 'assets/table.jpg',
            'correctWord': ' मेज़',
            'options': [' मेज़', 'कुर्सी', 'पेड़'],
          },
        {
          "sentence": "मैं ____ आज स्कूल जा रहा हूँ।",
          "correctWord": "आज",
          "options": ["आज", "काम", "गाता", "खेलते"],
        },
        {
          "sentence": "वह ____ खेल रही है।",
          "correctWord": "खेल",
          "options": ["खेल", "काम", "आज", "गाता"],
        },
        {
          "sentence": "बच्चे ____ पानी पीते हैं।",
          "correctWord": "पानी",
          "options": ["खेल", "पानी", "आज", "गाता"],
        },
  {
        'image': 'assets/tree.jpg',
        'correctWord': 'पेड़',
        'options': ['पेड़', 'मेज़', 'कंप्यूटर'],
      },
        {
          "sentence": "आप ____ उत्तर दीजिये।",
          "correctWord": "उत्तर",
          "options": ["खेल", "पानी", "उत्तर", "गाता"],
        },
        {
          "sentence": "तुम ____ कहाँ जा रहे हो?",
          "correctWord": "कहाँ",
          "options": ["खेल", "पानी", "उत्तर", "कहाँ"],
        },
        {
          "sentence": "आप ____ चलते हो?",
          "correctWord": "क्यों",
          "options": ["क्यों", "पानी", "उत्तर", "कहाँ"],
        },
        {
          "sentence": "मेरे पास ____ किताबें हैं।",
          "correctWord": "दो",
          "options": ["एक", "तीन", "चार", "दो"],
        },
        {
          "sentence": "तुम्हारी टोपी ____ है।",
          "correctWord": "लाल",
          "options": ["नीली", "पीली", "हरी", "लाल"],
        },
        {
          "sentence": "मेरा घर ____ बड़ा है।",
          "correctWord": "बहुत",
          "options": ["काफी", "थोड़ा", "ज्यादा", "बहुत"],
        },
        {
          "sentence": "उसकी किताब ____ है।",
          "correctWord": "छोटी",
          "options": ["बड़ी", "लंबी", "छोटी", "मोटी"],
        },
        {
          "sentence": "तुम __ कहाँ जा रहे हो?",
          "correctWord": "कहाँ",
          "options": ["कहाँ", "क्यों", "कब", "किसको"],
        },
        {
          "sentence": "वह __ खुशी से हंस रहा था।",
          "correctWord": "पूरी",
          "options": ["कम", "अधिक", "अच्छी", "पूरी"],
        },
        {
          "sentence": "मेरे पास __ पैसे नहीं हैं।",
          "correctWord": "कुछ",
          "options": ["कम", "ज्यादा", "कुछ", "बहुत"],
        },
        {
          "sentence": "उसने __ फल खाया।",
          "correctWord": "सभी",
          "options": ["कुछ", "अधिक", "सभी", "बहुत"],
        },
        {
          "sentence": "राम __ अच्छा लड़का है।",
          "correctWord": "सच",
          "options": ["झूठ", "सच", "अच्छा", "बुरा"],
        },
        {
          "sentence": "वह __ लड़की को पसंद करता है।",
          "correctWord": "सबसे",
          "options": ["सबसे", "बहुत", "कुछ", "अधिक"],
        },
        {
          "sentence": "तुम __ बहुत अच्छे हो।",
          "correctWord": "सच",
          "options": ["झूठ", "सच", "कम", "ज्यादा"],
        },
        {
          "sentence": "राम __ काम करता है।",
          "correctWord": "हमेशा",
          "options": ["कभी", "कभी नहीं", "कब", "हमेशा"],
        },
        {
          "sentence": "वह __ पार्टी में नहीं जा सकता।",
          "correctWord": "कभी",
          "options": ["कभी", "कभी नहीं", "अभी", "कब"],
        },
        {
          "sentence": "तुम __ खुश हो।",
          "correctWord": "सच",
          "options": ["झूठ", "सच", "बुरे", "अच्छे"],
        },
        {
          "sentence": "हम __ खेल रहे हैं।",
          "correctWord": "अभी",
          "options": ["कभी", "कभी नहीं", "अभी", "कब"],
        },
        {
          "sentence": "वह __ अच्छा लगता है।",
          "correctWord": "बहुत",
          "options": ["कम", "अधिक", "बहुत", "सब"],
        },
        {
          "sentence": "मैं __ पानी पीता हूँ।",
          "correctWord": "भी",
          "options": ["भी", "नहीं", "केवल", "अधिक"],
        },
        {
          "sentence": "वह __ उच्च बोलता है।",
          "correctWord": "हमेशा",
          "options": ["कभी", "कभी नहीं", "हमेशा", "कब"],
        },
        {
          "sentence": "मैं __ चाय पी रहा हूँ।",
          "correctWord": "अभी",
          "options": ["कभी", "कभी नहीं", "अभी", "कब"],
        },
        {
          "sentence": "तुम __ क्या कर रहे हो?",
          "correctWord": "क्या",
          "options": ["क्या", "कहाँ", "कब", "कितना"],
        },
        {
          "sentence": "हम __ खाना खा रहे हैं।",
          "correctWord": "अभी",
          "options": ["कभी", "कभी नहीं", "अभी", "कब"],
        },
        {
          "sentence": "तुम __ वहाँ जा रहे हो?",
          "correctWord": "क्यों",
          "options": ["कहाँ", "क्यों", "कब", "किसको"],
        },
        {
          "sentence": "वह __ अच्छे बंदर हैं।",
          "correctWord": "सभी",
          "options": ["कुछ", "अधिक", "सभी", "बहुत"],
        },
        {
          "sentence": "उसने __ खेला।",
          "correctWord": "क्रिकेट",
          "options": ["हॉकी", "फुटबॉल", "बास्केटबॉल", "क्रिकेट"],
        },

      ];
    }

    _currentUser = widget.user;
  }


  // final List<Map<String, dynamic>> sentences = [
  //   {'sentence': 'She ____ a doctor.', 'correctWord': 'is', 'options': ['am', 'is', 'are']},
  //   {
  //     'image': 'assets/lis.png',
  //     'correctWord': 'headphone',
  //     'options': ['headphone', 'phone', 'PC'],
  //   },
  //   {'sentence': 'They ____ in Paris.', 'correctWord': 'live', 'options': ['live', 'lives', 'living']},
  //   {
  //     'image': 'assets/apple.jpg',
  //     'correctWord': 'apple',
  //     'options': ['apple', 'grapes', 'mango'],
  //   },
  //   {'sentence': 'He ____ a teacher.', 'correctWord': 'is', 'options': ['is', 'am', 'are']},
  //   {
  //     'image': 'assets/cat.jpg',
  //     'correctWord': 'cat',
  //     'options': ['cat', 'dog', 'lion'],
  //   },
  //   {'sentence': 'We ____ happy.', 'correctWord': 'are', 'options': ['are', 'is', 'am']},
  //   {
  //     'image': 'assets/lis.png',
  //     'correctWord': 'headphone',
  //     'options': ['headphone', 'phone', 'PC'],
  //   },
  //   {'sentence': 'She ____ the dishes.', 'correctWord': 'washes', 'options': ['washes', 'washing', 'wash']},
  //   {'sentence': 'He ____ his dog.', 'correctWord': 'walks', 'options': ['walks', 'walking', 'walk']},
  //   {'sentence': 'We ____ at the park.', 'correctWord': 'play', 'options': ['play', 'playing', 'plays']},
  //   {
  //     'image': 'assets/laptop.jpg',
  //     'correctWord': 'laptop',
  //     'options': ['laptop', 'Mobile', 'measurement'],
  //   },
  //   {'sentence': 'She ____ the violin.', 'correctWord': 'plays', 'options': ['plays', 'playing', 'play']},
  //   {'sentence': 'He ____ in the garden.', 'correctWord': 'works', 'options': ['works', 'working', 'work']},
  //   {
  //     'image': 'assets/table.jpg',
  //     'correctWord': 'Table',
  //     'options': ['Table', 'chair', 'tree'],
  //   },
  //   {'sentence': 'They ____ at the cafe.', 'correctWord': 'work', 'options': ['work', 'working', 'works']},
  //   {'sentence': 'He ____ a coffee.', 'correctWord': 'drinks', 'options': ['drinks', 'drinking', 'drink']},
  //   {
  //     'image': 'assets/tree.jpg',
  //     'correctWord': 'Tree',
  //     'options': ['Tree', 'table', 'PC'],
  //   },
  //   {'sentence': 'He ____ to school.', 'correctWord': 'goes', 'options': ['goes', 'going', 'go']},
  //   {'sentence': 'She ____ a sandwich.', 'correctWord': 'makes', 'options': ['makes', 'making', 'make']},
  //   {'sentence': 'They ____ basketball.', 'correctWord': 'play', 'options': ['play', 'playing', 'plays']},
  //   {'sentence': 'He ____ in the garden.', 'correctWord': 'works', 'options': ['works', 'working', 'work']},
  //   {'sentence': 'We ____ the guitar.', 'correctWord': 'play', 'options': ['play', 'playing', 'plays']},
  //   {'sentence': 'She ____ her teeth.', 'correctWord': 'brushes', 'options': ['brushes', 'brushing', 'brush']},
  //   {'sentence': 'He ____ to school.', 'correctWord': 'goes', 'options': ['goes', 'going', 'go']},
  //   {'sentence': 'They ____ in the park.', 'correctWord': 'play', 'options': ['play', 'playing', 'plays']},
  //   {'sentence': 'She ____ the violin.', 'correctWord': 'plays', 'options': ['plays', 'playing', 'play']},
  //   {'sentence': 'He ____ his lunch.', 'correctWord': 'eats', 'options': ['eats', 'eating', 'eat']},
  //   {'sentence': 'We ____ in the pool.', 'correctWord': 'swim', 'options': ['swim', 'swimming', 'swims']},
  //   {'sentence': 'They ____ dinner.', 'correctWord': 'eat', 'options': ['eat', 'eating', 'eats']},
  //   {'sentence': 'She ____ at the library.', 'correctWord': 'studies', 'options': ['studies', 'study', 'studying']},
  //   {'sentence': 'He ____ a bike.', 'correctWord': 'rides', 'options': ['rides', 'riding', 'ride']},
  //   {'sentence': 'They ____ in the kitchen.', 'correctWord': 'cook', 'options': ['cook', 'cooking', 'cooks']},
  //   {'sentence': 'She ____ the piano.', 'correctWord': 'plays', 'options': ['plays', 'playing', 'play']},
  //   {'sentence': 'He ____ the guitar.', 'correctWord': 'plays', 'options': ['plays', 'playing', 'play']},
  //   {'sentence': 'They ____ basketball.', 'correctWord': 'play', 'options': ['play', 'playing', 'plays']},
  // ];

  int currentSentenceIndex = 0;
  String selectedWord = '';
  bool answeredCorrectly = false;
  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006875),
      appBar: AppBar(
        title: Text('Language Learning Game'),
        backgroundColor: Color(0xFF006875),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sentences[currentSentenceIndex].containsKey('sentence'))
              Text(
                sentences[currentSentenceIndex]['sentence'].replaceFirst('____', selectedWord),
                style: TextStyle(fontSize: 20),
              ),
            if (sentences[currentSentenceIndex].containsKey('image'))
              Image.asset(
                sentences[currentSentenceIndex]['image'],
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            SizedBox(height: 20),
            Text(
              answeredCorrectly != null
                  ? answeredCorrectly
                  ? 'Correct!'
                  : 'Incorrect!'
                  : 'Select any option',
              style: TextStyle(
                color: answeredCorrectly != null
                    ? answeredCorrectly
                    ? Colors.green
                    : Colors.red
                    : Colors.black, // Default color if no option is selected
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                for (final option in sentences[currentSentenceIndex]['options'])
                  ElevatedButton(
                    onPressed: () => _checkAnswer(option),
                    child: Text(option),
                  ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedWord.isNotEmpty ? _nextSentence : null,
              child: Text('Continue'),
            ),
            SizedBox(height: 20),
            Text('Points: $points'),
          ],
        ),
      ),
    );
  }

  void _checkAnswer(String word) {
    final correctWord = sentences[currentSentenceIndex]['correctWord'];
    setState(() {
      selectedWord = word;
      answeredCorrectly = (word == correctWord);
      if (answeredCorrectly) {
        points++; // Increment points if the answer is correct
      }
    });
  }

  void _nextSentence() {
    setState(() {
      currentSentenceIndex = Random().nextInt(sentences.length);
      selectedWord = '';
      answeredCorrectly = false; // Reset correctness status
    });
  }
}
