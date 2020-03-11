import 'dart:async';

import 'package:bloc_generic_streams/bloc_generic_streams.dart';
import 'package:rxdart/rxdart.dart';

class PublishStream<T> extends BlocBase {
  PublishStream() : _publishSubject = PublishSubject<T>();

  final PublishSubject<T> _publishSubject;

  StreamSink<T> get sink => _publishSubject.sink;

  ValueStream<T> get stream => _publishSubject.shareValue();

  ValueStream<T> get debounce => _publishSubject.debounce((_) {
        return TimerStream<dynamic>(true, const Duration(milliseconds: 1500));
      }).shareValue();

  T get value => _publishSubject.publishValue().value;

  @override
  void dispose() {
    _publishSubject?.close();
  }
}
