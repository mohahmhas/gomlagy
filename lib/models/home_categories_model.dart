import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gomalgy/helpers/http_exception.dart';
import 'package:http/http.dart' as http;

class ImageSlider {
  final String id;
  final String offerimage;
  final String createdat;
  final String updatedat;
  final String offerimagepath;

  ImageSlider({
    @required this.id,
    @required this.offerimage,
    @required this.createdat,
    @required this.updatedat,
    @required this.offerimagepath,
  });
}
