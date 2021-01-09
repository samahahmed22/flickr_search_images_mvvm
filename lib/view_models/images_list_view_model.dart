import 'package:flutter/widgets.dart';

import '../models/image_model.dart';
import '../services/flickr_search_images_web_service.dart';
import '../services/flickr_search_images_cash_service.dart';
import '../models/images_list_model.dart';
import './image_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class ImagesListViewModel extends ChangeNotifier {
  List<ImageViewModel> _images = [];
  ImagesListModel _imagesData;
  int _currentPage;
  int _nextPage = 1;
  int _imagesPerPage;
  String _searchText;
  int _totalNumberOfImages;
  int _totalNumberOfPages;
  List<String> _searchHistory;
  ImagesListModel _imagesDataToCash;
  var _allImagesListToCash;
  LoadingStatus loadingStatus = LoadingStatus.completed;

  List<ImageViewModel> get imagesList => _images;

  String get searchText => _searchText;

  Future<void> startSearchingForImages(String imageTitle, int perPage) async {
    if (_searchText != imageTitle) {
      _currentPage = 0;
      _nextPage = 1;
      _imagesPerPage = perPage;
      _searchText = imageTitle;
      _images = [];
      _imagesData = await FlickrSearchImagesCashService()
          .loadImagesFromCash((_searchText));
      await fetchImagesByTitle(_searchText, _imagesPerPage);
      if (_images.isEmpty) {
        this.loadingStatus = LoadingStatus.empty;
      } else {
        this.loadingStatus = LoadingStatus.completed;
      }
    notifyListeners();
    }
  }

  Future<void> fetchImagesByTitle(String imageTitle, int perPage) async {
    if (_imagesData == null || _nextPage > 1) {
      _imagesData = await FlickrSearchImagesWebService()
          .loadImagesFromFlickr(_searchText, _imagesPerPage, _nextPage);
      if (_allImagesListToCash == null) {
        _allImagesListToCash = _imagesData.imagesList;
      } else {
        _allImagesListToCash.addAll(_imagesData.imagesList);
      }
      _imagesDataToCash = _imagesData;
      _imagesDataToCash.imagesList = _allImagesListToCash;
      await FlickrSearchImagesCashService()
          .saveImagestoCash(_searchText, _imagesDataToCash);
    }
    List<ImageModel> _imagesList =
        _imagesData.imagesList.map((e) => ImageModel.fromJson(e)).toList();
    this._images.addAll(
        _imagesList.map((image) => ImageViewModel(image: image)).toList());
    _currentPage = _imagesData.currentPage;
    _totalNumberOfImages = _imagesData.totalNumberOfImages;
    _totalNumberOfPages = _imagesData.totalNumberOfPages;
    if (_currentPage == _totalNumberOfPages) {
      _imagesPerPage = _totalNumberOfImages - _images.length;
      _nextPage = 1;
    } else {
      _nextPage = _currentPage + 1;
    }
  }

  Future<void> loadMoreImages() async {
    if (_nextPage > 1) {
      await fetchImagesByTitle(_searchText, _imagesPerPage);
      notifyListeners();
    }
  }

  Future<List<String>> getSearchHistory() async {
    _searchHistory =
        await FlickrSearchImagesCashService().getAllSearchHistory();
    return _searchHistory;
  }
}
