import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information();

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text('Welcome to [Your App Name]'

      'At [Your App Name], we are dedicated to helping you learn languages effectively and enjoyably. Here is what you need to know about our app:'

      '1. Language Courses:'
      'Explore a wide range of language courses tailored to your interests and goals. Whether you are learning for travel, work, school, or personal enrichment, we have courses to suit your needs. Choose from popular languages like Spanish, French, German, Mandarin Chinese, Japanese, Italian, and many more'

      '2. Interactive Lessons:'
          'Our interactive lessons are designed to make language learning fun and engaging. Dive into a variety of exercises, including vocabulary drills, grammar lessons, listening comprehension tasks, speaking practice, and writing exercises. Our gamified approach keeps you motivated as you progress through levels and earn rewards.'

      '3. Personalized Learning:'
      'We understand that every learner is unique. That is why our app adapts to your learning style, proficiency level, and pace. Our intelligent algorithms personalize lesson content and practice exercises to optimize your learning experience and help you achieve your language goals faster.'

      '4. Accessibility:'
      'Learn languages anytime, anywhere with our app, available on iOS, Android, and the web. Whether you are on the go or at home, access our lessons and practice activities conveniently from your preferred device.'

      '5. Community Engagement:'
      'Join a vibrant community of language learners from around the world. Connect with fellow learners, participate in discussions, and practice your language skills together. Join clubs, compete with friends, and stay motivated on your language learning journey.'

      '6. Premium Features:'
      'Upgrade to [Your App Name] Plus for an ad-free experience, offline access to lessons, progress tracking, and additional features to enhance your learning experience.'

      '7. Effectiveness:'
      'Our app is designed to be effective for learners of all levels. Whether you are a beginner getting started with a new language or an advanced learner looking to refine your skills, our comprehensive courses and engaging lessons will help you succeed.'

      'Start your language learning journey with [Your App Name] today and unlock a world of opportunities!'),
          )
        ],
      ),
    );
  }
}
