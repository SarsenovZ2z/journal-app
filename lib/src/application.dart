import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/core/services/api.dart';
import 'package:journal/src/future/data/datasources/user_remote_data_source.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_states.dart';
import 'package:journal/src/future/presentation/pages/auth_screen.dart';
import 'package:journal/src/themes/dark_theme.dart';
import 'package:journal/src/themes/light_theme.dart';
import 'package:flutter/services.dart';
import 'future/presentation/pages/home_screen.dart';
import 'locator.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).backgroundColor,
      statusBarIconBrightness: Theme.of(context).brightness,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: ((context) => sl<AuthCubit>()..tryToAuthByToken())),
      ],
      child: MaterialApp(
        title: 'Journal',
        debugShowCheckedModeBanner: false,
        theme: LightTheme().getThemeData(),
        darkTheme: DarkTheme().getThemeData(),
        themeMode: ThemeMode.system,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: ((context, state) {
            if (state is AuthenticatedState) {
              return const HomeScreen();
            } else if (state is AuthenticatingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const AuthScreen();
            }
          }),
        ),
      ),
    );
  }
}
