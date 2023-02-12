import 'package:journal/src/features/auth/presentation/widgets/only_authenticated.dart';
import 'package:journal/src/features/books/presentation/pages/book_screen.dart';
import 'package:journal/src/features/books/presentation/pages/books_screen.dart';
import 'package:journal/src/features/profile/presentation/pages/profile_screen.dart';

import 'core/services/url_resolver.dart';

Future<UrlResolver> init() async {
  return UrlResolver(
    routes: [
      RouteWrapper(
        name: 'home',
        path: '/',
        child: (context, args) => const OnlyAuthenticated(
          child: BooksScreen(),
        ),
      ),
      RouteWrapper(
        name: 'book',
        path: '/book/{id}',
        where: {
          'id': '\\d+',
        },
        child: (context, args) => OnlyAuthenticated(
          child: BookScreen(id: int.parse(args['id'])),
        ),
      ),
      RouteWrapper(
        name: 'profile',
        path: '/profile',
        child: (context, args) => const OnlyAuthenticated(
          child: ProfileScreen(),
        ),
      ),
    ],
  );
}
