import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/widgets/only_authenticated_screen.dart';
import 'package:journal/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:journal/src/themes/dark_theme.dart';
import 'package:journal/src/themes/light_theme.dart';
import 'package:flutter/services.dart';
import 'features/journal/presentation/pages/home_screen.dart';
import 'locator.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarIconBrightness: Theme.of(context).brightness,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>()..tryToAuthByToken(),
        ),
      ],
      child: MaterialApp(
        title: 'Journal',
        debugShowCheckedModeBanner: false,
        theme: LightTheme().getThemeData(),
        darkTheme: DarkTheme().getThemeData(),
        themeMode: ThemeMode.system,
        routes: {
          '/': (context) => const OnlyAuthenticatedScreen(
                child: HomeScreen(),
              ),
          '/profile': (context) => const OnlyAuthenticatedScreen(
                child: ProfileScreen(),
              ),
        },
      ),
    );
  }
}
