class Carburant {
  Carburant({
    required this.nom,
    required this.prix,
    required this.ruptureType
  });
  
  final String nom;
  final double? prix;
  final String? ruptureType;
}