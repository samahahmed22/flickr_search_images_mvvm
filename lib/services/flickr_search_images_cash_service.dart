import 'package:hive/hive.dart';

import '../models/images_list_model.dart';

class FlickrSearchImagesCashService {
  Future<List<String>> getAllSearchHistory() async {
    var flickrImages = await Hive.openBox<ImagesListModel>('flickr_images');
    
    var searchHistory = flickrImages.keys;
    List<String> searchHistoryList =
        searchHistory.map((e) => e.toString()).toList();

    return searchHistoryList;
  }

  Future<ImagesListModel> loadImagesFromCash(String searchText) async {
    var flickrImages = await Hive.openBox<ImagesListModel>('flickr_images');
    ImagesListModel images = flickrImages.get(searchText);
    return images;
  }

  Future<void> saveImagestoCash(
      String searchText, ImagesListModel images) async {
    var flickrImages = await Hive.openBox<ImagesListModel>('flickr_images');
    flickrImages.put(searchText, images);
  }
}
