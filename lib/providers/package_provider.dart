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
    final url = Uri.parse('https://localhost:777/Package/$folio');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
//      _package = Package.fromJson(json.decode(response.body));
        _package = Package.fromMap(json.decode(response.body));
        _errorMessage = null;
      } else if (response.statusCode == 404) {
        _package = null;
        _errorMessage = 'No se encontró el envío con ese folio.';
      } else {
        _package = null;
        _errorMessage = 'Error al consultar la API.';
      }

    } catch (error) {
      _package = null;
      _errorMessage = 'Error al consultar la API: $error';
    }

    notifyListeners();
  }

}