import 'package:journal/src/core/remote_data_source.dart';
import 'package:journal/src/features/journal/data/models/book_model.dart';

abstract class BookDataSource {
  Future<List<BookModel>> getCurrentUserBooks();
}

class BookRemoteDataSource extends RemoteDataSource implements BookDataSource {
  BookRemoteDataSource({required super.api});

  @override
  Future<List<BookModel>> getCurrentUserBooks() async {
    try {
      final response = await api.httpClient.get('/v1/book/my');
      print(response);
      return [];
    } catch (_) {
      throw Exception('Someting went wrong!');
    }
  }
}
