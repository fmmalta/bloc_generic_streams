import 'package:bloc_generic_streams/bloc_generic_streams.dart';
import 'package:bloc_generic_streams/src/bloc_provider.dart';

class HomeBloc extends BlocBase {
  int counter = 0;
  final GenericBloc<int> counterStream = GenericBloc<int>();

  void incrementCounter() {
    counterStream.sink(++counter);
  }

  @override
  void dispose() {
    counterStream?.dispose();
  }
}
