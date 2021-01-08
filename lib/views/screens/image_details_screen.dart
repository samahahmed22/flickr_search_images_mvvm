import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../view_models/images_list_view_model.dart';
import '../widgets/my_app_bar.dart';

class ImageDetailsScreen extends StatelessWidget {
  static const routeName = '/image-details';

  @override
  Widget build(BuildContext context) {
    final imageId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedImage = Provider.of<ImagesListViewModel>(
      context,
      listen: false,
    ).getImageById(imageId);
    return Scaffold(
      appBar: MyAppBar(loadedImage.title),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: loadedImage.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset('assets/loading.gif'),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red[600],),
              ),
              // FadeInImage(
              //   placeholder: AssetImage('assets/loading.gif'),
              //   image: NetworkImage(loadedImage.url_m),
              //   fit: BoxFit.cover,
              // ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                ListTile(
                  title: Text(
                    loadedImage.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    loadedImage.description,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  leading: Icon(Icons.view_headline),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    loadedImage.views + ' Views',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: Icon(Icons.remove_red_eye),
                ),
                ListTile(
                  title: Text(
                    'Taken at ' + loadedImage.date_taken,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: Icon(Icons.calendar_today),
                ),
                ListTile(
                  title: Text(
                    'Taken By ' + loadedImage.owner,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: Icon(Icons.person),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
