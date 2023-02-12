import 'package:equatable/equatable.dart';

class ChapterEntity extends Equatable {
  final String name;
  final String content;

  const ChapterEntity({required this.name, required this.content});

  @override
  List<Object?> get props => [
        name,
        content,
      ];
}
