import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_generic_streams.dart';

class GenericStream<T> extends BlocBase {
  GenericStream()
      : _behaviorSubject = BehaviorSubject<T>(),
        _publishSubject = PublishSubject<T>();

  GenericStream.seeded({@required T seed})
      : _behaviorSubject = BehaviorSubject<T>.seeded(seed),
        _publishSubject = PublishSubject<T>();

  final BehaviorSubject<T> _behaviorSubject;
  final PublishSubject<T> _publishSubject;

  Function(T) get sink => _behaviorSubject.sink.add;

  ValueStream<T> get stream => _behaviorSubject.shareValue();

  ValueStream<T> get streamDebounce => _behaviorSubject
      .debounce(
        (_) => TimerStream<dynamic>(true, const Duration(milliseconds: 1500)),
      )
      .shareValue();

  T get value => _behaviorSubject.value;

  @override
  void dispose() => _behaviorSubject?.close();
}
