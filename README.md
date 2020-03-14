# Bloc Generic Streams

This package was create to be an easy implementation of Didier Boelens's BlocProvider and including a new way to use a BehaviorSubject using GenericStream class that creates an object more simple with Dart's Generics.

I built this package because when you have an application like an Uber application, which was my case, others bloc packages didn't attended my expectations, so, I created this, more simple and more intuitive. You only need to create your Bloc extending BlocBase and then creating a BlocProvider in whatever screen you desire.

OBS: I'll implement other subjects, like Publish and Replay subject.
## Example:
```dart
    import 'package:bloc_generic_streams/bloc_generic_streams.dart';
    
    class HomeBloc extends BlocBase {
      int counter = 0;
      final GenericBehavior<int> counterStream = GenericBehavior<int>();

      // Other Subjects

      //final GenericPublish<int> publishSubject = GenericPublish<int>();

      //final GenericReplay<int> publishSubject = GenericReplay<int>();
    
      void increment() {
        counterStream.sink(++counter);
      }
    
      @override
      void dispose() {
        counterStream?.dispose();
      }
    }
```

counterStream variable contains all most important methods exposed, like:
- sink (StreamSink)
- stream (ValueStream)
- stream debounce (1500 ms)

## How to use BlocProvider?
```dart
class HomeScreen extends StatelessWidget {
	//Instantiate our bloc... HomeBloc in our case
      final HomeBloc _bloc = HomeBloc();
    
      @override
      Widget build(BuildContext context) {
	  //Return a BlocProvider instance specifying its type
        return BlocProvider<HomeBloc>(
          blocBuilder: () => _bloc, // Build and create our bloc
          blocDisposer: (_) => _bloc?.dispose(), // Dispose when it's not necessary anymore
          child: Scaffold(
            appBar: AppBar(title: Text('Home Screen')),
            floatingActionButton: FloatingActionButton(
              onPressed: _bloc.increment,
              child: Icon(Icons.add),
            ),
            body: Center(
              child: StreamBuilder<int>(
                initialData: _bloc.counter,
				//Retrieving Stream from _bloc's GenericStream object
                stream: _bloc.counterStream.stream,
                builder: (_, AsyncSnapshot<int> snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
            ),
          ),
        );
      }
    }
```
Now it's very easy to implement a BLoC class and to manipulate the way you want.

## Retrieving Bloc

Follow the same pattern from other packages, like this:
```dart
final HomeBloc _bloc = BlocProvider.of<HomeBloc>(context);
```

With that, you can access and retrieved any stream/method inside your Bloc.



__