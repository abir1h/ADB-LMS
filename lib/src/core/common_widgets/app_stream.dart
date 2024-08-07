import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

abstract class DataState<T>{}
class LoadingState<T> extends DataState<T>{}
class DataLoadedState<T> extends DataState<T>{
  final T data;
  DataLoadedState(this.data);
}
class EmptyState<T> extends DataState<T>{
  final String message;
  IconData icon;
  EmptyState({required this.message, this.icon = Icons.weekend_outlined});
}


class AppStreamController<T>{
  final BehaviorSubject<DataState<T>> _streamController = BehaviorSubject<DataState<T>>();
  Stream<DataState<T>> get stream => _streamController.stream;
  DataState<T>? get value => _streamController.valueOrNull;

  void add(DataState<T> data){
    if(!_streamController.isClosed){
      _streamController.sink.add(data);
    }
  }
  void dispose(){
    _streamController.close();
  }
}

class AppStreamBuilder<T> extends StatelessWidget {
  final Stream<DataState<T>> stream;
  final Widget Function(BuildContext context) loadingBuilder;
  final Widget Function(BuildContext context, T data) dataBuilder;
  final Widget Function(BuildContext context, String message, IconData icon) emptyBuilder;
  const AppStreamBuilder({Key? key,required this.stream,required this.loadingBuilder,required this.dataBuilder,required this.emptyBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
      stream: stream,
      initialData: LoadingState(),
      builder: (context, snapshot){
        var state = snapshot.data!;
        if(state is DataLoadedState<T>){
          return dataBuilder(context,state.data);
        }
        else if(state is EmptyState<T>){
          return emptyBuilder(context,state.message, state.icon);
        }
        else{
          return loadingBuilder(context);
        }
      },
    );
  }
}

