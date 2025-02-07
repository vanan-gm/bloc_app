import 'package:intl/intl.dart';

extension DateTimeExt on DateTime{
  String formatDMY(){
    return DateFormat.yMMMd().format(this);
  }
}