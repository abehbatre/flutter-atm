
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';


class ImageUtils {

  // —————————————————————————————————————————————————————————————————————————————
  // imageTo ....
  // —————————————————————————————————————————————————————————————————————————————
  static String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  // —————————————————————————————————————————————————————————————————————————————
  // base64To ....
  // —————————————————————————————————————————————————————————————————————————————
  static MemoryImage base64ToImage(String base64String) {
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  static Uint8List base64ToUnit8list(String base64String) {
    return base64Decode(base64String);
  }

  static String fileToBase64(File imgFile) {
    return base64Encode(imgFile.readAsBytesSync());
  }

  static Future networkImageToBase64(Uri url) async {
    http.Response response = await http.get(url);
    return base64.encode(response.bodyBytes);
  }

  Future assetImageToBase64(String path) async {
    ByteData bytes = await rootBundle.load(path);
    return base64.encode(Uint8List.view(bytes.buffer));
  }



  // —————————————————————————————————————————————————————————————————————————————
  // compress
  // —————————————————————————————————————————————————————————————————————————————

// 1. compress file and get Uint8List
  static Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result!.length);
    return result;
  }

  // 2. compress file and get file.
  static Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  // 3. compress asset and get Uint8List.
  static Future<Uint8List?> testCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  // 4. compress Uint8List and get another Uint8List.
  static Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }
}