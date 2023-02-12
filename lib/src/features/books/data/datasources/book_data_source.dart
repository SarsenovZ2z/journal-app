import 'package:journal/src/core/remote_data_source.dart';
import 'package:journal/src/features/books/data/models/book_model.dart';

abstract class BookDataSource {
  Future<List<BookModel>> getCurrentUserBooks();

  Future<BookModel> getBook(int id);
}

class BookRemoteDataSource extends RemoteDataSource implements BookDataSource {
  BookRemoteDataSource({required super.api});

  @override
  Future<List<BookModel>> getCurrentUserBooks() async {
    try {
      final response = await api.httpClient.get('/v1/book/my');
      return List<BookModel>.from(
        response.data['data'].map(
          (bookJson) => BookModel.fromJson(bookJson),
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BookModel> getBook(int id) async {
    try {
      final response = await api.httpClient.get('/v1/book/$id');
      return BookModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
