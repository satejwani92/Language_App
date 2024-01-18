import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class progress {
  User? user = FirebaseAuth.instance.currentUser;
  var box = Hive.box("LocalDB");

  List progress_get() {
    // print(box.get("Lang")[]);
    List last_prog = box.get("Progress");
    return last_prog;
  }

  void progress_update(pos) {
    List last_prog = box.get("Progress");
    last_prog[pos] += 1;
    box.put("Progress", last_prog);
    this.update_firebase();
  }

  void update_firebase() {
    List last_prog = box.get("Progress");

    CollectionReference userBase =
        FirebaseFirestore.instance.collection('user');

    userBase.doc(this.user!.email.toString()).update({
      'Selected_lang': box.get("Lang")['Selected_lang'],
      'Progress': last_prog,
      'leader_board': box.get("Lang")['leader_board'] + 1
      //;eader/////******* */
    });
  }

  void get_firebase_progress() async {
    CollectionReference userBase =
        FirebaseFirestore.instance.collection('user');

    userBase.doc(this.user!.email.toString()).get().then((value) async {
      Map<String, dynamic>? langData = value.data() as Map<String, dynamic>?;

      if (langData != null) {
        box.put("Lang", langData);

        String currentLang = box.get("current_lang").toString();
        if (langData.containsKey(currentLang) &&
            langData[currentLang] != null) {
          List? progressList = langData[currentLang]['Progress'];

          if (progressList != null) {
            box.put("Progress", progressList);
          }
        }
      }
    });
  }
}
