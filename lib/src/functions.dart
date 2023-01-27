Future<ReturnType?> slowAwait<ReturnType>({
  Future? f,
  Duration? duration = const Duration(milliseconds: 1500),
}) async {
  ReturnType? result;
  await Future.wait([
    if (f != null) f.then((value) => result = value),
    if (duration != null) Future.delayed(duration, () => null),
  ]);
  return result;
}
