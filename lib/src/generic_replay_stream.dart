import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_generic_streams.dart';

class GenericBehaviorSubj<T> extends BlocBase {
  GenericBehaviorSubj() : _replaySubject = ReplaySubject<T>();

  GenericBehaviorSubj.seeded({@required T seed})
      : _replaySubject = ReplaySubject<T>();

  final ReplaySubject<T> _replaySubject;

  Function(T) get sink => _replaySubject.sink.add;

  ValueStream<T> get stream => _replaySubject.shareValue();

  ValueStream<T> get streamDebounce => _replaySubject
      .debounce(
        (_) => TimerStream<dynamic>(true, const Duration(milliseconds: 1500)),
      )
      .shareValue();

  T get value => _replaySubject.shareValue().value;

  @override
  void dispose() => _replaySubject?.close();
}
