import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/journal/domain/usecases/auth/get_temporary_password.dart';
import 'package:journal/src/features/journal/presentation/bloc/Auth/password/password_states.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final GetTemporaryPassword getTemporaryPassword;

  PasswordCubit({
    required this.getTemporaryPassword,
  }) : super(NotRequestedState());

  Future<void> getPassword({required String email}) async {
    if (state is RequestingPasswordState) {
      return;
    }

    emit(RequestingPasswordState());

    final failureOrNothing =
        await getTemporaryPassword(GetTemporaryPasswordParams(email: email));

    failureOrNothing.fold((error) {
      emit(PasswordRequestFailedState(failure: error));
    }, (_) {
      emit(PasswordIssuedState());
    });
  }

  void reset() {
    emit(NotRequestedState());
  }

  void forgetLastError() {
    if (state is PasswordRequestFailedState) {
      emit(NotRequestedState());
    }
  }
}
