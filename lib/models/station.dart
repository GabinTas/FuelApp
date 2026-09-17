import "carburant.dart";

class Station {
  Station({
    required this.ville,
    required this.cp,
    required this.adresse,
    required this.carburant,
    required this.prix,
    required this.rupture_stock,
    required this.rupture_type,
    required this.tousLesCarburants
  });

  final String ville;
  final String cp;
  final String adresse;
  final String carburant;
  final double? prix;
  final bool rupture_stock;
  final String? rupture_type;
  final List<Carburant> tousLesCarburants;

  factory Station.fromJson(Map<String, dynamic> json, String carburantChoisi) {
    final ville = json['ville'] as String;
    final cp = json['cp'] as String;
    final adresse = json['adresse'] as String;
    final carburant = carburantChoisi;
    final prix = json['${carburantChoisi}_prix'] as double?;
    final rupture_stock = json['${carburantChoisi}_rupture_debut'] != null;
    final rupture_type = json['${carburantChoisi}_rupture_type'] as String?;
    final tousLesCarburants = json.keys
    .where((key) => key.endsWith("_prix"))
    .map((key){
      final nom = key.replaceAll('_prix', '');
      final prix = json[key] as double?;
      final rupture_type = json['${nom}_rupture_type'] as String?;
      return Carburant(nom: nom, prix: prix, ruptureType: rupture_type);
    })
    .toList();

    return Station(
      ville: ville,
      cp: cp,
      adresse: adresse,
      carburant: carburant,
      prix: prix,
      rupture_stock: rupture_stock,
      rupture_type: rupture_type,
      tousLesCarburants: tousLesCarburants,
    );
  }
}
