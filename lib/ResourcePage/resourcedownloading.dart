import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:easy_localization/easy_localization.dart';

class ResourceBrain {
  var box = Hive.box("LocalDB");
  CollectionReference dataBase =
      FirebaseFirestore.instance.collection('DataBase');
  CollectionReference userBase = FirebaseFirestore.instance.collection('user');
  User? user = FirebaseAuth.instance.currentUser;

  late List<dynamic> Question;

  Future<void> initaldownloadlang() async {
    box.put("current_lang", 1);
    await userBase.doc(user!.email.toString()).get().then((value) async {
      await box.put("Lang", value.data());
      await box.put("count_lang", await box.get("Lang")["count_lang"]);
      print(await box.get("Lang")["count_lang"]);
    });
    var lang = await box.get("Lang")!["1"]['Selected_lang'];

    dataBase.doc('English_Data').get().then((value) {
      box.put("Data_downloaded", value.data());
      print(value.data());
      Map<dynamic, dynamic> RawData = value.data() as Map<dynamic, dynamic>;
      RawData.forEach((key, value) async {
        Question = await translateFunction(RawData, key, lang[1]);
        box.put(key.toString(), Question);
      });
    });

    dataBase.doc('LISTENING').get().then((value) {
      box.put('SPEAKING', value.data());
      log("${value.data()}");

      Map<dynamic, dynamic> SpeakingRawData =
          value.data() as Map<dynamic, dynamic>? ?? {};

      SpeakingRawData.forEach((key, value) async {
        Question = await translateFunction(SpeakingRawData, key, lang[1]);
        box.put(key.toString(), Question);
      });
    });
  }

  Future<void> additionalangdownloadlang(int n) async {
    userBase.doc(user!.email.toString()).get().then((value) {
      box.put("Lang", value.data());
      box.put("count_lang", box.get("Lang")["count_lang"]);
    });

    dataBase
        .doc('English_Data')
        .get()
        .then((value) => box.put("Data_downloaded", value.data()));

    dataBase
        .doc('LISTENING')
        .get()
        .then((value) => box.put('SPEAKING', value.data()));
    var lang = await box.get("Lang")[n.toString()]['Selected_lang'];
    box.put("current_lang", n);

    Map<dynamic, dynamic> RawData = box.get("Data_downloaded");
    RawData.forEach((key, value) async {
      Question = await translateFunction(RawData, key, lang[1]);
      box.put(key.toString(), Question);
    });

    Map<dynamic, dynamic> SpeakingRawData = box.get("SPEAKING");
    SpeakingRawData.forEach((key, value) async {
      Question = await translateFunction(SpeakingRawData, key, lang[1]);
      box.put(key.toString(), Question);
    });
  }

  Future addUserdetails(List selectedlang, String email) async {
    await FirebaseFirestore.instance.collection("user").doc(email).set({
      "1": {
        'Selected_lang': selectedlang,
        'Progress': [0, 0, 0, 0],
        'name': user?.displayName.toString()
      },
      "count_lang": 1,
      "leader_board": 0
    });
    box.put("current_lang", 1);
  }

  Future appendlang(List selectedlang, String email, String name) async {
    box.put("count_lang", (box.get("count_lang") + 1));
    await FirebaseFirestore.instance.collection("user").doc(email).update({
      (box.get("count_lang")).toString(): {
        'Selected_lang': selectedlang,
        'Progress': [0, 0, 0, 0],
        'name': name
      },
      "count_lang": (box.get("count_lang"))
    });

    userBase.doc(user!.email.toString()).get().then((value) {
      box.put("Lang", value.data());
      box.put("current_lang", box.get("count_lang"));
      additionalangdownloadlang(box.get("current_lang"));
    });
  }

  Future<List<String>> translateFunction(
      RawData, key, List<String> tolang) async {
    List<String> TempQuestion = List<String>.from(RawData[key]);
    for (int i = 0; i < TempQuestion.length; i++) {
      TempQuestion[i] = tr(TempQuestion[i], args: [tolang.toString()]);
    }
    return TempQuestion;
  }
}
