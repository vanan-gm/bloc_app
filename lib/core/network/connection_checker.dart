import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class ConnectionChecker{
  Future<bool> get isInternetConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker{
  final InternetConnectionChecker connectionChecker;
  ConnectionCheckerImpl({required this.connectionChecker});

  @override
  Future<bool> get isInternetConnected async => await connectionChecker.hasConnection;

}