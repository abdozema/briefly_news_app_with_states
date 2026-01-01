import 'package:flutter/foundation.dart';

class NewsModel {
  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.author,
    required this.content,
  });

  final String author;
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String publishedAt;
  final String content;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['source']?['id'] ?? "no id",
      source: json['source']?['name'] ?? 'Unknown Source',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? 'https://placehold.co/200x200/png',
      publishedAt: json['publishedAt'] ?? "2025-01-01T00:00:00Z",
      content: json['content'] ?? "Full article content not available.",
      author: json['author'] ?? 'Unknown Author',
    );
  }
}
