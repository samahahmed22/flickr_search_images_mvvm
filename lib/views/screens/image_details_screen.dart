import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../view_models/image_view_model.dart';
import '../widgets/my_app_bar.dart';

class ImageDetailsScreen extends StatelessWidget {

  ImageViewModel image;
  ImageDetailsScreen({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(this.image.title),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: this.image.url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Image.asset('assets/loading.gif'),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red[600],
                ),
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
                    this.image.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    this.image.description,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  leading: Icon(Icons.view_headline),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    this.image.views + ' Views',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: Icon(Icons.remove_red_eye),
                ),
                ListTile(
                  title: Text(
                    'Taken at ' + this.image.date_taken,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  leading: Icon(Icons.calendar_today),
                ),
                ListTile(
                  title: Text(
                    'Taken By ' + this.image.owner,
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
