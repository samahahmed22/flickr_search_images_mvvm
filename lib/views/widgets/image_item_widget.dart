import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/image_details_screen.dart';
import '../../view_models/image_view_model.dart';

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<ImageViewModel>(context, listen: false);
    return ClipRRect(
      // borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ImageDetailsScreen.routeName,
              arguments: image.id,
            );
          },
          child: CachedNetworkImage(
            imageUrl: image.url,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset('assets/loading.gif'),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red[600],
            ),
          ),
          // FadeInImage(
          //   placeholder: AssetImage('assets/loading.gif'),
          //   image: NetworkImage(image.url),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
