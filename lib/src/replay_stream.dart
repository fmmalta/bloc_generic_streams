import 'dart:async';

import 'package:bloc_generic_streams/bloc_generic_streams.dart';
import 'package:rxdart/rxdart.dart';

class ReplayStream<T> extends BlocBase {
  ReplayStream() : _replaySubject = ReplaySubject();

  final ReplaySubject _replaySubject;

  StreamSink<T> get sink => _replaySubject.sink;

  ValueStream<T> get stream => _replaySubject.shareValue();

  ValueStream<T> get debounce => _replaySubject.debounce((_) {
        return TimerStream<dynamic>(true, const Duration(milliseconds: 1500));
      }).shareValue();

  List<T> get value => _replaySubject.values;

  @override
  void dispose() {
    _replaySubject?.close();
  }
}
