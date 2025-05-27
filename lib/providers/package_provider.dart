import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:aps_2025_1_app_movil/models/package_model.dart';
//class ShipmentProvider {
//class ParcelProvider {

class PackageProvider with ChangeNotifier {
  Package? _package;
  String? _errorMessage;

  Package? get package => _package;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPackage(String folio) async {
    final url = Uri.parse('http://192.168.1.68:777/api/tracking/$folio');
    
    try {
      final response = await http.get(url);
      print('Response body: ' + response.body);

      if (response.statusCode == 200) {
        _package = Package.fromMap(json.decode(response.body)['body']);
        _errorMessage = null;
      } else if (response.statusCode == 404) {
        _package = null;
        _errorMessage = 'No se encontró el envío con ese folio. (Error 404)';
      } else {
        _package = null;
        _errorMessage = 'Error al consultar la API.\nCódigo: ${response.statusCode}';
      }

    } catch (error) {
      _package = null;
      _errorMessage = 'No se pudo conectar con el servidor.\nDetalle: $error';
    }

    notifyListeners();
  }
}