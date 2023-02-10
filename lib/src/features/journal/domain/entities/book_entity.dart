import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int id;
  final String name;
  final String? image;

  const BookEntity({required this.id, required this.name, this.image});

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
