import 'package:flutter/material.dart';

class UrlResolver {
  final List<RouteWrapper> routes;

  UrlResolver({required this.routes});

  Route<dynamic>? resolve(RouteSettings settings) {
    final RouteWrapper? route = findRoute(settings);

    if (route == null) {
      return null;
    }

    return route.build(settings);
  }

  RouteWrapper? findRoute(RouteSettings settings) {
    for (RouteWrapper route in routes) {
      if (route.test(settings)) {
        return route;
      }
    }
    return null;
  }
}

class RouteWrapper {
  final String name;
  final String path;
  final Widget Function(BuildContext context, Map<String, dynamic> args) child;
  final Map<String, String> where;

  RouteWrapper({
    required this.name,
    required this.path,
    required this.child,
    this.where = const {},
  });

  Route<dynamic> build(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => child(context, _extractPathArguments(settings)),
    );
  }

  bool test(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);

    return _regex.hasMatch(uri.path);
  }

  Map<String, dynamic> _extractPathArguments(RouteSettings settings) {
    final match = _regex.firstMatch(settings.name!);
    return {
      for (var argName in _pathArguments.keys)
        argName: match!.namedGroup(argName)
    };
  }

  RegExp get _regex {
    String regex = _pathArguments.entries
        .fold(
          path,
          (previousValue, arg) => previousValue.replaceAll(
              "{${arg.key}}", "(?<${arg.key}>${arg.value})"),
        )
        .replaceAll(r'/', r'\/');

    return RegExp("^$regex\$");
  }

  Map<String, String> get _pathArguments {
    final matches = RegExp(r'(\{(?<name>\w+)\})')
        .allMatches(path)
        .map((match) => match.namedGroup('name'));
    return {for (var name in matches) name!: where[name] ?? ".+"};
  }
}
