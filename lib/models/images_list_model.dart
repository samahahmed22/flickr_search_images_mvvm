import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'images_list_model.g.dart';

@HiveType(typeId: 0)
class ImagesListModel {
  @HiveField(0)
  List<dynamic> imagesList;
  @HiveField(1)
  int imagesPerPage;
  @HiveField(2)
  int currentPage;
  @HiveField(3)
  int totalNumberOfPages;
  @HiveField(4)
  int totalNumberOfImages;

  ImagesListModel(
      {@required this.imagesList,
      @required this.imagesPerPage,
      @required this.currentPage,
      @required this.totalNumberOfPages,
      @required this.totalNumberOfImages});

  factory ImagesListModel.fromJson(Map<String, dynamic> jsonData) {
    return ImagesListModel(
      imagesList: jsonData['photo'],
      imagesPerPage: jsonData['per_page'],
      currentPage: jsonData['page'],
      totalNumberOfPages: jsonData['pages'],
      totalNumberOfImages: int.parse(jsonData['total']),
    );
  }
}
