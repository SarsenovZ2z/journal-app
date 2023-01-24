import 'package:equatable/equatable.dart';

class AuthTokenEntity extends Equatable {
  final String accessToken;
  final String? refreshToken;

  const AuthTokenEntity({
    required this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
