import 'package:flutter/material.dart';
import 'package:images/models/images_list_model.dart';
import 'package:provider/provider.dart';

import '../widgets/my_app_bar.dart';
import '../../view_models/images_list_view_model.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  List<String> historyList = [];
  List<String> searchItems = [];
  String searchText;
  @override
  void initState() {
    var searchHistory = Provider.of<ImagesListViewModel>(context, listen: false)
        .getSearchHistory()
        .then((list) {
      if (list == null) {
        setState(() {
          historyList = [];
          searchItems = [];
        });
      } else {
        setState(() {
          historyList.addAll(list);
          searchItems.addAll(list);
        });
      }
    });
  }

  void filterSearchResults(String query) {
    List<String> searchHistoryList = [];
    if (query.isNotEmpty) {
      searchItems.forEach((item) {
        if (item.toUpperCase().contains(query.toUpperCase())) {
          searchHistoryList.add(item);
        }
      });
      setState(() {
        searchItems.clear();
        searchItems.addAll(searchHistoryList);
      });
      return;
    } else {
      setState(() {
        searchItems.clear();
        searchItems.addAll(historyList);
      });
    }
  }

  void saveSearchText() async {
    if (searchText.trim().length > 0) {
      if (!historyList.contains(searchText)) {
        historyList.insert(0, searchText);
      }

      Navigator.of(context).pushNamed(
        'search',
        arguments: searchText,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Search for images'),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchText = value;
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ))),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => saveSearchText()),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      searchItems[index],
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    leading: Icon(Icons.history),
                    onTap: () {
                      setState(() {
                        searchText = searchItems[index];
                        editingController.text = searchText;
                      });
                      filterSearchResults(searchItems[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
