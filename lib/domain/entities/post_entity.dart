// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import '../../utils/enums/post_type.dart';

class PostEntity {
  final String id;
  final PostType type;
  final String userId;
  final String subtitle;
  final DateTime date;
  final String? contentUrl;
  final String? contentPath;
  final File? localContent;
  final int likes;
  final List<String> comments;
  final int shares;

  PostEntity({
    required this.id,
    required this.type,
    required this.userId,
    required this.subtitle,
    required this.date,
    this.contentUrl,
    this.contentPath,
    this.localContent,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  PostEntity copyWith({
    String? id,
    PostType? type,
    String? userId,
    String? subtitle,
    DateTime? date,
    String? contentUrl,
    String? contentPath,
    File? localContent,
    int? likes,
    List<String>? comments,
    int? shares,
  }) {
    return PostEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      contentUrl: contentUrl ?? this.contentUrl,
      contentPath: contentPath ?? this.contentPath,
      localContent: localContent ?? this.localContent,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
    );
  }
}
