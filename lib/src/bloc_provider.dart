import 'package:flutter/cupertino.dart';

typedef _BlocBuilder<T> = T Function();
typedef _BlocDisposer<T> = Function(T);

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key key,
    @required this.blocBuilder,
    this.blocDisposer,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  final _BlocBuilder<T> blocBuilder;
  final _BlocDisposer<T> blocDisposer;

  @override
  _BlocProvider<T> createState() => _BlocProvider<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    _BlocProviderInherited<T> provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget;

    return provider?.bloc;
  }
}

class _BlocProvider<T extends BlocBase> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocBuilder();
    super.initState();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(child: widget.child, bloc: bloc);
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({Key key, @required Widget child, this.bloc})
      : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
