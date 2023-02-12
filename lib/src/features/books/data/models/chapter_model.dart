import 'package:journal/src/features/books/domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.name,
    required super.content,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      name: json['name'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "content": content,
    };
  }
}
