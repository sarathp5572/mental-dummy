import 'dart:io';

import 'package:video_compress/video_compress.dart';

Future<MediaInfo> compressVideo(File file) async {
  MediaInfo? info = await VideoCompressApi.compressVideo(file);
  return info!;
}

class VideoCompressApi {
  static Future<MediaInfo?> compressVideo(File file) async {
    try {
      await VideoCompress.setLogLevel(0);
      return VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.LowQuality,
        includeAudio: true,
        // deleteOrigin: true,
      );
    } catch (e) {
      VideoCompress.cancelCompression();
    }
    return null;
  }
}
