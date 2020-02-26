import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_generic_streams.dart';

class GenericStream<T> extends BlocBase {
  GenericStream() : _subject = BehaviorSubject<T>();

  GenericStream.seeded({@required T seed})
      : _subject = BehaviorSubject<T>.seeded(seed);

  final BehaviorSubject<T> _subject;

  Function(T) get sink => _subject.sink.add;

  ValueStream<T> get stream => _subject.shareValue();

  ValueStream<T> get streamDebounce => _subject
      .debounce(
        (_) => TimerStream<dynamic>(true, const Duration(milliseconds: 1500)),
      )
      .shareValue();

  T get value => _subject.value;

  @override
  void dispose() => _subject?.close();
}
