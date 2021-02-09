import 'dart:async';

import 'package:bloc_generic_streams/bloc_generic_streams.dart';
import 'package:rxdart/rxdart.dart';

class GenericReplay<T> extends BlocBase {
  GenericReplay() : _replaySubject = ReplaySubject();

  final ReplaySubject _replaySubject;

  StreamSink<T> get sink => _replaySubject.sink;

  ValueStream<T> get stream => _replaySubject.shareValue();

  ValueStream<T> get debounce => _replaySubject.debounce((_) {
        return TimerStream<dynamic>(true, const Duration(milliseconds: 1500));
      }).shareValue();

  List<T> get value => _replaySubject.values;

  bool get isClosed => _replaySubject.isClosed;

  void add(T event) {
    if (!isClosed) _replaySubject.add(event);
  }

  void addError(Object error, [StackTrace stackTrace]) {
    if (!isClosed) _replaySubject.addError(error, stackTrace);
  }

  @override
  void dispose() {
    _replaySubject?.close();
  }
}
