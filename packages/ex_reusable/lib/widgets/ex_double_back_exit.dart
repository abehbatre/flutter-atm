import 'package:flutter/material.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_double_back_exit
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///
class ExDoubleBackToCloseWidget extends StatefulWidget {
  final Widget child;

  const ExDoubleBackToCloseWidget({required this.child});

  @override
  _ExDoubleBackToCloseWidgetState createState() => _ExDoubleBackToCloseWidgetState();
}

class _ExDoubleBackToCloseWidgetState extends State<ExDoubleBackToCloseWidget> {
  int? _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final _currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_lastTimeBackButtonWasTapped != null && (_currentTime - _lastTimeBackButtonWasTapped!) < exitTimeInMillis) {
      // ScaffoldMessenger.of(context).removeCurrentSnackBar();
      return true;
    } else {

      // Get.snackbar(
      //   "Keluar dari aplikasi?",
      //   "Ketuk sekali lagi untuk keluar",
      //   backgroundColor: Color(0x73ff0000),
      //   barBlur: 8.0,
      //   snackPosition: SnackPosition.TOP,
      //   margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
      //   duration: 2.seconds,
      // );
      return false;
    }
  }
}
