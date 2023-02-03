Future<void> delay({int milliseconds = 1500}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
