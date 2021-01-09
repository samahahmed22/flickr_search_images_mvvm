import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../view_models/images_list_view_model.dart' as im;
import '../widgets/image_item_widget.dart';
import '../widgets/my_app_bar.dart';
import '../../view_models/image_view_model.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search-result-screen';
  final String text;
  SearchResultScreen(this.text);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<ImageViewModel> images = [];
  String searchText;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      double itemSize = width / 3;
      int perPage = (((height / itemSize).round()) + 1) * 3;

      searchText = widget.text;
      Provider.of<im.ImagesListViewModel>(context, listen: false)
          .startSearchingForImages(searchText, perPage);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future _loadMore(String title) async {
    await Provider.of<im.ImagesListViewModel>(context, listen: false)
        .loadMoreImages();
  }

  Widget _buildList(im.ImagesListViewModel imagesList) {
    images = imagesList.imagesList;
    switch (imagesList.loadingStatus) {
      case im.LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
      case im.LoadingStatus.completed:
        return LazyLoadScrollView(
          onEndOfPage: () => _loadMore(searchText),
          child: Scrollbar(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: images.length,
              itemBuilder: (ctx, i) => ImageItemWidget(images[i]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
            ),
          ),
        );
      case im.LoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    im.ImagesListViewModel imagesList =
        Provider.of<im.ImagesListViewModel>(context);
    images = imagesList.imagesList;
    return Scaffold(
      appBar: MyAppBar(searchText),
      body: _buildList(imagesList),
    );
  }
}
