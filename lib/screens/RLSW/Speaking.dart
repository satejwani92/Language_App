import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_lang/learning/speakinglearning.dart';
import 'package:final_lang/progress_brain.dart/progress.dart';

class Speaking extends StatefulWidget {
  late ColorScheme dync;
  Speaking({required this.dync});

  @override
  State<Speaking> createState() => _SpeakingState();
}

class _SpeakingState extends State<Speaking> {
  List<String> speakingcatg = [];
  progress prog = progress();

  @override
  void initState() {
    super.initState();

    // Initialize Hive
    Hive.initFlutter();

    // Open Hive box
    var box = Hive.box("LocalDB");
    Map? speaking = box.get("SPEAKING");

    if (speaking != null) {
      speakingcatg = speaking.keys.map((key) => key.toString()).toList();
    } else {
      // Handle the case where "SPEAKING" is not found or is null.
      // You may want to provide a default value or log an error.
      log("Warning: 'SPEAKING' not found or is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: TopheadCLipper(),
            child: Container(
              color: widget.dync.primary,
              height: MediaQuery.of(context).size.height / 3.5,
              child: Center(
                child: Text(
                  "Speaking",
                  style: TextStyle(
                    color: widget.dync.primaryContainer,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
              itemCount: speakingcatg.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    !(index <= prog.progress_get()[2])
                        ? {}
                        : Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SpeakingLearning(
                                cat: speakingcatg[index],
                                dync: widget.dync,
                              ),
                            ),
                          );
                  },
                  child: (index <= prog.progress_get()[2])
                      ? Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.dync.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Center(
                            child: Text(
                              speakingcatg[index],
                              style: TextStyle(
                                color: widget.dync.secondaryContainer,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: widget.dync.primary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 10,
                              child: Center(
                                child: Text(
                                  speakingcatg[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: widget.dync.primaryContainer,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.8,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: widget.dync.primary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 10,
                                child: const Center(
                                  child: Icon(Icons.lock),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopheadCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 40);

    path.quadraticBezierTo(
      size.width / 4,
      size.height - 80,
      size.width / 2,
      size.height - 40,
    );

    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; //if new instance has a different instance than old instance
    //then you must return true;
  }
}
