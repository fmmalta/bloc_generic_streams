import 'package:example/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_generic_streams/bloc_generic_streams.dart';

void main() => runApp(App());

class HomeScreen extends StatelessWidget {
  final HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      blocBuilder: () => _bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Home Screen')),
        floatingActionButton: FloatingActionButton(
          onPressed: _bloc.incrementCounter,
          child: Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Click on the FAB button to increment the value above:'),
              StreamBuilder<int>(
                initialData: _bloc.counter,
                stream: _bloc.counterStream.stream,
                builder: (_, AsyncSnapshot<int> snapshot) {
                  return Text('${snapshot.data}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
