import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'lat_lng.dart';

export 'dart:math' show min, max;

export 'package:page_transition/page_transition.dart';

export 'lat_lng.dart';
export 'place.dart';

T valueOrDefault<T>(T value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

String dateTimeFormat(String format, DateTime dateTime) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    return timeago.format(dateTime);
  }
  return DateFormat(format).format(dateTime);
}

Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  try {
    await launch(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

DateTime get getCurrentTimestamp => DateTime.now();

bool get isAndroid => !kIsWeb && Platform.isAndroid;

LatLng? cachedUserLocation;
Future<Object?> getCurrentUserLocation(
        {LatLng? defaultLocation, bool cached = false}) async =>
    cached && cachedUserLocation != null
        ? cachedUserLocation
        : queryCurrentUserLocation().then((loc) {
            if (loc != null) {
              cachedUserLocation = loc;
            }
            return loc;
          }).onError((error, _) {
            return defaultLocation;
          });

Future<LatLng?> queryCurrentUserLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  final position = await Geolocator.getCurrentPosition();
  return position != null && position.latitude != 0 && position.longitude != 0
      ? LatLng(position.latitude, position.longitude)
      : null;
}

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  // color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}
