import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:journal/src/features/auth/domain/entities/auth_token_entity.dart';

class Api {
  late final Dio httpClient;

  AuthTokenEntity? authToken;

  Api({this.authToken}) {
    httpClient = Dio(
      BaseOptions(
        baseUrl: dotenv.get(
          'BACKEND_URL',
          fallback: 'http://localhost:8000/',
        ),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    httpClient.interceptors.clear();
    httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            options.headers['Authorization'] =
                "$_accessTokenType $_accessToken";
          }
          return handler.next(options);
        },
        // onError: (error, handler) async {
        //   // if (_accessToken != null && error.response?.statusCode == 401) {
        //   //   if (_refreshToken is String) {
        //   //     if (await refreshAccessToken()) {
        //   //       return handler.resolve(await _retry(error.requestOptions));
        //   //     }
        //   //   }

        //   //   await _logout();
        //   // }
        //   return handler.next(error);
        // },
      ),
    );
  }

  factory Api.usingAuthToken(AuthTokenEntity authToken) => Api(
        authToken: authToken,
      );

  void setAuthToken(AuthTokenEntity? authToken) {
    this.authToken = authToken;
  }

  Future<bool> refreshAccessToken() async {
    // @TODO: implement refresh token
    // final response = await _httpClient
    //     .post('auth/refresh-token', data: {'refreshToken': refreshToken});

    // if (response.statusCode == 201) {
    //   // response.data;
    //   return true;
    // }
    return false;
  }

  AuthTokenEntity? get _authToken {
    if (authToken is AuthTokenEntity) {
      return authToken;
    }
    return null;
    // final currentAuthState = _authState;
    // return currentAuthState is AuthenticatedState
    //     ? currentAuthState.authToken
    //     : null;
  }

  String? get _accessToken {
    return _authToken?.accessToken;
  }

  String? get _accessTokenType {
    return _authToken?.type;
  }

  // String? get _refreshToken {
  //   return _authToken?.refreshToken;
  // }

  // Future<void> _logout() async {
  //   // return authCubit.logout();
  // }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return httpClient.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }
}
