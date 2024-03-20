import 'package:final_lang/admin/upload_game.dart';
import 'package:final_lang/learning/speakinglearning.dart';
import 'package:final_lang/screens/RLSW/reading.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:final_lang/admin/callbbox.dart';

class InsHome extends StatefulWidget {
  late ColorScheme dync;
  InsHome({required this.dync});

  @override
  State<InsHome> createState() => _InsHomeState();
}

class _InsHomeState extends State<InsHome> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to a new page based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadListeningScreen()),
        );
        break;
      // case 1:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SpeakingLearning(cat: ca, dync:widget.dync)),
      //   );
        break;
    // case 2:
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => SettingsScreen()),
    //   );
    // //   break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.dync.primary,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: widget.dync.inversePrimary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: GNav(
          duration: const Duration(milliseconds: 1000),
          tabBorderRadius: 20,
          tabMargin: const EdgeInsets.all(3),
          color: widget.dync.primary,
          tabBackgroundColor: widget.dync.primary,
          activeColor: Colors.white,
          backgroundColor: widget.dync.inversePrimary,
          selectedIndex: _selectedIndex, // Provide the selected index
          tabs: [
            GButton(
              icon: Icons.home,
            ),
            GButton(icon: Icons.mail),
            GButton(
              icon: Icons.settings,
            ),
          ],
          onTabChange: _onTabChange, // Assign the callback function
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          UploadListeningScreen(),
          // Replace the below Placeholder widgets with your actual screens
          Placeholder(),
          Placeholder(),
        ],
      ),
    );
  }
}
