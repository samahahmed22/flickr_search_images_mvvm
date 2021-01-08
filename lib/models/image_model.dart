import 'package:flutter/foundation.dart';

class ImageModel {
  final String id;
  final String title;
  final String owner;
  final String url;
  final String date_taken;
  final String description;
  final String views;

  ImageModel({
      @required this.id,
      @required this.title,
      @required this.owner,
      @required this.url,
      @required this.date_taken,
      @required this.description,
      @required this.views
  });

  factory ImageModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return ImageModel(
      id: jsonData['id'],
      title: jsonData['title'],
      owner: jsonData['ownername'],
      url: jsonData['url_m'],
      date_taken: jsonData['datetaken'],
      description: jsonData['description']['_content'],
      views: jsonData['views'],
    );
  }
}
