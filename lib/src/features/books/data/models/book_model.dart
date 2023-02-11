import 'package:journal/src/features/books/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }
}
