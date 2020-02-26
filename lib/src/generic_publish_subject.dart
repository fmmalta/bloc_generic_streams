import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_generic_streams.dart';

class GenericPublishSubj<T> extends BlocBase {
  GenericPublishSubj() : _publishSubject = PublishSubject<T>();

  GenericPublishSubj.seeded({@required T seed})
      : _publishSubject = PublishSubject<T>();

  final PublishSubject<T> _publishSubject;

  Function(T) get sink => _publishSubject.sink.add;

  ValueStream<T> get stream => _publishSubject.shareValue();

  ValueStream<T> get streamDebounce => _publishSubject
      .debounce(
        (_) => TimerStream<dynamic>(true, const Duration(milliseconds: 1500)),
      )
      .shareValue();

  T get value => _publishSubject.shareValue().value;

  @override
  void dispose() => _publishSubject?.close();
}
