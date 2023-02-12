import 'package:equatable/equatable.dart';
import 'package:journal/src/features/books/domain/entities/chapter_entity.dart';

class BookEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final List<ChapterEntity> chapters;

  const BookEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.chapters,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        chapters,
      ];
}
