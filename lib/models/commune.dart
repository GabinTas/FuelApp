class Commune {
  Commune({
    required this.nom,
    required this.codePostal,
    required this.codeDepartement,
  });

  final String nom;
  final String codePostal;
  final String codeDepartement;

  factory Commune.fromJson(Map<String, dynamic> json) {
    final codesPostaux = json['codesPostaux'] as List<dynamic>;
    return Commune(
      nom: json['nom'] as String,
      codePostal: codesPostaux.isNotEmpty ? codesPostaux.first as String : '',
      codeDepartement: json['codeDepartement'] as String,
    );
  }
}