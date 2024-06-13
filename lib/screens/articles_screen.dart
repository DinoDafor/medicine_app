import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Скоро здесь будут статьи",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
