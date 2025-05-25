//import 'dart:convert';

class Package {
  Package({
    required this.folio,
    required this.status,
    required this.date,
    required this.time,
  });

  final String folio;
  final String status;
  final String date;
  final String time;

  /*
  factory Package.fromJson(String str) =>
      Package.fromMap(json.decode(str));
  */

  factory Package.fromMap(Map<String, dynamic> json) {
    return Package(
      folio: json['folio'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
    );
  }
}