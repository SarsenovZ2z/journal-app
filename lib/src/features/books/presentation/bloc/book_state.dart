import 'package:equatable/equatable.dart';

abstract class BookState extends Equatable {}

class BookNotLoadedState extends BookState {
  @override
  List<Object?> get props => [];
}

class BookLoadingState extends BookNotLoadedState {}

class BookLoadingFailedState extends BookNotLoadedState {}

class BookLoadedState extends BookState {
  @override
  List<Object?> get props => [];
}
