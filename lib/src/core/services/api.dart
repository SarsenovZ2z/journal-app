import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_states.dart';

class Api {
  final AuthCubit authCubit;
  final AuthTokenEntity? authToken;
  final String _baseUrl =
      dotenv.get('BACKEND_URL', fallback: 'http://localhost:8000/');

  final Dio httpClient = Dio();

  Api({required this.authCubit, this.authToken}) {
    httpClient.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!options.path.contains('http')) {
          options.path = _baseUrl + options.path;
        }
        if (_accessToken is String) {
          options.headers['Authorization'] = _accessToken;
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (_accessToken != null && error.response?.statusCode == 401) {
          if (_refreshToken is String) {
            if (await refreshAccessToken()) {
              return handler.resolve(await _retry(error.requestOptions));
            }
          }

          await _logout();
        }
        return handler.next(error);
      },
    ));
  }

  Api usingAuthToken(AuthTokenEntity authToken) => Api(
        authCubit: authCubit,
        authToken: authToken,
      );

  Future<bool> refreshAccessToken() async {
    // TODO: implement refresh token
    // final response = await _httpClient
    //     .post('auth/refresh-token', data: {'refreshToken': refreshToken});

    // if (response.statusCode == 201) {
    //   // response.data;
    //   return true;
    // }
    return false;
  }

  AuthState get _authState {
    return authCubit.state;
  }

  AuthTokenEntity? get _authToken {
    if (authToken is AuthTokenEntity) {
      return authToken;
    }
    final currentAuthState = _authState;
    return currentAuthState is AuthenticatedState
        ? currentAuthState.authToken
        : null;
  }

  String? get _accessToken {
    return _authToken?.accessToken;
  }

  String? get _refreshToken {
    return _authToken?.refreshToken;
  }

  Future<void> _logout() async {
    return authCubit.logout();
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return httpClient.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
