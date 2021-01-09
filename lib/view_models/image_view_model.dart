import 'package:flutter/widgets.dart';

import '../models/image_model.dart';

class ImageViewModel {
  ImageModel _flicker_image;

  ImageViewModel({ImageModel image}) : _flicker_image = image;

  String get id {
    return _flicker_image.id;
  }

  String get title {
    return _flicker_image.title;
  }

  String get owner {
    return _flicker_image.owner;
  }

  String get url {
    return _flicker_image.url;
  }

  String get date_taken {
    return _flicker_image.date_taken;
  }

  String get description {
    return _flicker_image.description;
  }

   String get views {
    return _flicker_image.views;
  }
}