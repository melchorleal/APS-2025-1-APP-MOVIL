import 'dart:convert';

class Package {
  final String folio;
  final String status;
  final String completeDate;
  final String completeTime;

  Package({
    required this.folio,
    required this.status,
    required this.completeDate,
    required this.completeTime,
  });

  String get time {
  // Si el formato es siempre HH:mm:ss
    if (completeTime.length >= 5) {
      return completeTime.substring(0, 5);
    }
    return completeTime;
  }

  String get date {
    // Espera formato: Mon May 13 2024
    final parts = completeDate.split(' ');
    if (parts.length == 4) {
      // parts[2] = día, parts[1] = mes, parts[3] = año
      return '${parts[2]} ${parts[1]} ${parts[3]}';
    }
    return completeDate;
  }

  // Factory para crear desde JSON string
  factory Package.fromJson(String str) =>
      Package.fromMap(json.decode(str));

  // Factory para crear desde un Map
  factory Package.fromMap(Map<String, dynamic> json) => Package(
    folio: json["folio"]?.toString() ?? '',
    status: json["estatus"]?.toString() ?? '',
    completeDate: json["fecha"]?.toString() ?? '',
    completeTime: json["hora"]?.toString() ?? '',
  );
}