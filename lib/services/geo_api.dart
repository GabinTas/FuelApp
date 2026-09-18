import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/commune.dart';

class GeoApi {
  static Future<List<Commune>> searchCommunes(String query) async {
    if (query.isEmpty) return [];

    final uri = Uri.parse('https://geo.api.gouv.fr/communes').replace(
      queryParameters: {
        'nom': query,
        'boost': 'population',
        'limit': '10',
      },
    );

    final response = await http.get(uri);
    final json = jsonDecode(response.body) as List<dynamic>;

    return json
        .map((c) => Commune.fromJson(c as Map<String, dynamic>))
        .toList();
  }
}