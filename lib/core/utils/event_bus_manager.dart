import 'dart:async';

import 'package:event_bus/event_bus.dart';

class EventBusManager {
  /// 单例
  static EventBus _eventBus;
  static EventBus shared() {
    if(_eventBus == null) {
      _eventBus = EventBus();
    }
    return _eventBus;
  }

  /// 订阅者
  static Map<Type, List<StreamSubscription>> subscriptions = {};

  /// 添加监听事件
  /// [T] 事件泛型 必须要传
  /// [onData] 接受到事件
  /// [autoManaged] 自动管理实例，off 取消
  static StreamSubscription on<T extends Object>(void onData(T event),
      {Function onError,
        void onDone(),
        bool cancelOnError,
        bool autoManaged = true}) {
    StreamSubscription subscription = shared()?.on<T>()?.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    if (autoManaged == true) {
      if (subscriptions == null) subscriptions = {};
      List<StreamSubscription> subs = subscriptions[T.runtimeType] ?? [];
      subs.add(subscription);
      subscriptions[T.runtimeType] = subs;
    }
    return subscription;
  }

  /// 移除监听者
  /// [T] 事件泛型 必须要传
  /// [subscription] 指定
  static void off<T extends Object>({StreamSubscription subscription}) {
    if (subscriptions == null) subscriptions = {};
    if (subscription != null) {
      // 移除传入的
      List<StreamSubscription> subs = subscriptions[T.runtimeType] ?? [];
      subs.remove(subscription);
      subscriptions[T.runtimeType] = subs;
    } else {
      // 移除全部
      subscriptions[T.runtimeType] = null;
    }
  }

  /// 发送事件
  static void fire(event) {
    shared()?.fire(event);
  }
}


/// 传递当前视频TabBarView的下标
class VideoTabBarViewInEvent {
  int currentIndex;
  VideoTabBarViewInEvent(this.currentIndex);
}