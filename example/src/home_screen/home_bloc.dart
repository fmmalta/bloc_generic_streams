import 'package:bloc_generic_streams/bloc_generic_streams.dart';
import 'package:bloc_generic_streams/src/bloc_provider.dart';
import 'package:bloc_generic_streams/src/publish_stream.dart';
import 'package:bloc_generic_streams/src/replay_stream.dart';

class HomeBloc extends BlocBase {
  int counter = 0;
  final BehaviorStream<int> counterStream = BehaviorStream<int>();
  final PublishStream<String> stringStream = PublishStream<String>();
  final ReplayStream<double> doubleStream = ReplayStream<double>();

  void incrementCounter() {
    counterStream.sink.add(++counter);
  }

  @override
  void dispose() {
    counterStream?.dispose();
    stringStream?.dispose();
    doubleStream?.dispose();
  }
}
