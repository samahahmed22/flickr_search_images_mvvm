import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/image_details_screen.dart';
import '../../view_models/image_view_model.dart';

class ImageItemWidget extends StatelessWidget {

  ImageViewModel image;
  ImageItemWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ImageDetailsScreen(
                image: this.image,
              );
            }));
          },
          child: CachedNetworkImage(
            imageUrl: this.image.url ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset('assets/loading.gif'),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red[600],
            ),
          ),
        ),
      ),
    );
  }
}
