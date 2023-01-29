import 'package:equatable/equatable.dart';

class AuthTokenEntity extends Equatable {
  final String accessToken;
  final String? refreshToken;
  final String type;

  const AuthTokenEntity({
    required this.accessToken,
    this.refreshToken,
    this.type = 'Bearer',
  });

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        type,
      ];
}
