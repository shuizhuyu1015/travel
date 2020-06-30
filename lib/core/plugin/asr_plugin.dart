import 'package:flutter/services.dart';

class GLASRPlugin {
  static const MethodChannel _channel = const MethodChannel('gray.com/asr');

  // 开始录音
  static Future<String> start() async {
    return await _channel.invokeMethod('start');
  }

  // 停止录音
  static Future<String> stop() async {
    return await _channel.invokeMethod('stop');
  }

  // 取消录音
  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}
