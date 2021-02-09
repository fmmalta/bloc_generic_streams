import 'package:bloc_generic_streams/bloc_generic_streams.dart';

class HomeBloc extends BlocBase {
  int counter = 0;

  final GenericBehavior<int> counterStream = GenericBehavior<int>();
  final GenericPublish<String> stringStream = GenericPublish<String>();
  final GenericReplay<double> doubleStream = GenericReplay<double>();

  void incrementCounter() {
    if (counterStream.isOpen) counterStream.sink.add(++counter);
  }

  @override
  void dispose() {
    counterStream?.dispose();
    stringStream?.dispose();
    doubleStream?.dispose();
  }
}
