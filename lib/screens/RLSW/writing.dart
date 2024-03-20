import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui' as ui;

class Writing extends StatefulWidget {
  late ColorScheme dync;
  Writing({required this.dync});

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  String headingcheck = "🐧🐧🐧🐧🐧";

  // Initialize WritingBrain and other variables here
  late Color _selectedColor;
  List<Color> _availableColors = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange, // New color
    Colors.purple, // New color
  ];
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedColor = _availableColors[0]; // Set initial color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.dync.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20),
            child: Container(
              margin: const EdgeInsets.all(8),
              color: widget.dync.primary,
              child: Center(
                child: Text(
                  headingcheck,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.dync.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: SfSignaturePad(
                minimumStrokeWidth: 5,
                maximumStrokeWidth: 5,
                strokeColor: _selectedColor, // Use selected color
                key: _signaturePadKey,
                backgroundColor: widget.dync.primaryContainer,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (Color color in _availableColors)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _clearSignature();
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 11,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: widget.dync.inversePrimary,
              ),
              child: const Center(
                child: Text(
                  "Clear All",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to clear the signature
  void _clearSignature() {
    _signaturePadKey.currentState!.clear();
  }
}
