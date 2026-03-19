import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson $lessonId'),
      ),
      body: Center(
        child: Text('Lesson Detail: $lessonId'),
      ),
    );
  }
}
