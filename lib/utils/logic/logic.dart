import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

String flutterRandom() {
  Random random = Random();

  int randomValue = random.nextInt(1001);
  return randomValue.toString();
}

bool isImagePath(String filePath) {
  String extension = path.extension(filePath).toLowerCase();
  return extension == '.jpg' ||
      extension == '.jpeg' ||
      extension == '.png' ||
      extension == '.gif' ||
      extension == '.bmp' ||
      extension == '.webp';
}

bool isVideoPath(String filePath) {
  String extension = path.extension(filePath).toLowerCase();
  return extension == '.mp4' ||
      extension == '.avi' ||
      extension == '.mkv' ||
      extension == '.mov' ||
      extension == '.wmv' ||
      extension == '.flv' ||
      extension == '.webm';
}

String capitalText(String text) {
  if (text.isEmpty) {
    return "";
  } else {
    return text[0].toUpperCase() + text.substring(1);
  }
}
