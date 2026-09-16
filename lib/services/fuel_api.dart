import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/station.dart';

class GetStation {
  static Future<List<Station>> fetchStations(
    String ville,
    String carburant,
  ) async {
    final url =
        'https://data.economie.gouv.fr/api/explore/v2.1/catalog/datasets/prix-des-carburants-en-france-flux-instantane-v2/records';
    final uri = Uri.parse(
      url,
    ).replace(queryParameters: {'where': 'search(ville, "$ville")', 'limit': '100'});
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['results'] as List<dynamic>;
    final stations = result
        .where((s) => s['${carburant}_prix'] != null || s['${carburant}_rupture_debut'] != null )
        .map((s) => Station.fromJson(s, carburant))
        .toList();

    return stations;
  }
}
