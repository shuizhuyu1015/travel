import 'package:flutter/services.dart';

class GLSharePlugin {
  static const MethodChannel _channel = MethodChannel('gray.com/share');
  
  static Future<bool> showShare() async {
    return await _channel.invokeMethod('showShare');
  }
}