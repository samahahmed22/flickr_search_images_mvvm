import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/images_list_model.dart';

class FlickrSearchImagesWebService {
  static final String _apiKey = '044b31928540fe9dd1dd203e2b6c0dab';
  static final String _baseUrl = 'https://www.flickr.com/services/rest';
  static final String _method = 'flickr.photos.search';

  Future<ImagesListModel> loadImagesFromFlickr(
      String searchText, int imagesPerPage, int pageNumber) async {
    try {
      http.Response response =
          await http.get(_createURL(searchText, imagesPerPage, pageNumber));
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ImagesListModel images = ImagesListModel.fromJson(jsonData['photos']);
        return images;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  static String _createURL(
      String searchText, int imagesPerPage, int pageNumber) {
    String uri = _baseUrl +
        "?method=$_method" +
        "&api_key=$_apiKey" +
        "&text=$searchText" +
        "&format=json" +
        "&nojsoncallback=1" +
        "&per_page=$imagesPerPage" +
        "&page=$pageNumber" +
        "&extras=url_m,description,date_upload,date_taken,owner_name,views";

    return Uri.encodeFull(uri);
  }
}
