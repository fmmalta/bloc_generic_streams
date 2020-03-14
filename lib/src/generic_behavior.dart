import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_generic_streams.dart';

class GenericBehavior<T> extends BlocBase {
  GenericBehavior() : _behaviorSubject = BehaviorSubject<T>();

  GenericBehavior.seeded({@required T seed})
      : _behaviorSubject = BehaviorSubject<T>.seeded(seed);

  final BehaviorSubject<T> _behaviorSubject;

  StreamSink<T> get sink => _behaviorSubject.sink;

  Stream<T> get stream => _behaviorSubject.stream;

  Stream<T> get streamDebounce =>
      _behaviorSubject.debounceTime(const Duration(milliseconds: 1500));

//  Stream<T> get streamDebounce => _behaviorSubject.debounce(
//        (_) => TimerStream<dynamic>(true, const Duration(milliseconds: 1500)),
//      );

  T get value => _behaviorSubject.value;

  @override
  void dispose() => _behaviorSubject?.close();
}
