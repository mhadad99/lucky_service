part of 'my_app_cubit.dart';

@immutable
sealed class MyAppState {}

final class MyAppInitial extends MyAppState {}

final class MyAppAddInvoice extends MyAppState {}

final class MyAppAddServices extends MyAppState {}

final class MyAppChangeTheme extends MyAppState {}
