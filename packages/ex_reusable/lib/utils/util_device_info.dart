import 'dart:io';

import 'package:device_info/device_info.dart';

///   created               : Aditya Pratama
///   originalFilename      : device_info_util
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///
class DeviceInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> uuid() async {
    String id = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      id = androidInfo.androidId;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor;
    }
    return id;
  }

  Future<String> name() async {
    String name = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      name = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      name = iosInfo.utsname.machine;
    }
    return name;
  }

  Future<String> type() async {
    String type = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      type = androidInfo.type;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      type = iosInfo.name;
    }
    return type;
  }
}
