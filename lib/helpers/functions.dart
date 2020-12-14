import 'package:flutter/material.dart';

/// Navigate to a new route by passing a route widget
Future<dynamic> push(
  context,
  Widget widget,
) async {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

/// returns the file extension from url
String getFileExtFromUrl(String url) {
  if (url == null) throw new Exception("url cannot be null");
  return url.split('.').last;
}

/// returns the file name from path url
String getFileNameFromUrl(String url) {
  if (url == null) throw new Exception("url cannot be null");
  return url.split('/').last.split('.').first;
}

// https://www.youtube.com/watch?v=eZYtnzODpW4
/// return the yt video id from url
String getYoutubeId(String url) {
  if (!url.contains("http")) return null;
  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }
  return null;
}

/// returns true if [url] is a youtube url
bool isYT(String url) {
  if (url == null) throw new Exception("url cannot be null");
  if (getYoutubeId(url) == null) {
    return false;
  }
  return true;
}
