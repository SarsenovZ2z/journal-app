import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int id;
  final String name;

  const BookEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
