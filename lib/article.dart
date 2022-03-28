import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Article {
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  /**
 * tambahkan juga named constructor untuk mengonversi format json menjadi bentuk object Article
 */

  Article.fromJson(Map<String, dynamic> article) {
    author = article['author'];
    title = article['title'];
    description = article['description'];
    url = article['url'];
    urlToImage = article['urlToImage'];
    publishedAt = article['publishedAt'];
    content = article['content'];
  }
}

//**
//Karena Future kita mengembalikan String, maka
//kita perlu mengonversinya menjadi objek yang kita siapkan.
//Proses konversi ini juga dikenal dengan json parsing */

List<Article> parseArticles(String? json) {
  if (json == null) {
    return [];
  }

  //Kemudian kita akan panggil fungsi parseArticles() tersebut dari dalam fungsi builder.
  builder:
  (context, snapshot) {
    final List<Article> articles = parseArticles(snapshot.data);
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return _buildArticleItem(context, articles[index]);
      },
    );
  };

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Article.fromJson(json)).toList();
}

//method _buildArticleItem
Widget _buildArticleItem(BuildContext context, Article article) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      article.urlToImage,
      width: 100,
    ),
    title: Text(article.title),
    subtitle: Text(article.author),
  );
}
