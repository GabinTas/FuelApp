import 'package:flutter/material.dart';
import '../models/station.dart';

class StationDetailScreen extends StatelessWidget{
  const StationDetailScreen({super.key, required this.station});
  final Station station;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.adresse),
      ),
      body: ListView.builder(
        itemCount: station.tousLesCarburants.length,
        itemBuilder: (context, index) {
          final carburant = station.tousLesCarburants[index];
          return ListTile(
            title: Text(carburant.nom),
            subtitle: carburant.ruptureType != null
                ? Text('Rupture (${carburant.ruptureType})')
                : null,
            trailing: Text(
              carburant.prix != null
                  ? '${carburant.prix!.toStringAsFixed(3)} €'
                  : 'N/A',
            ),
          );
        },
      ),
    );
  }
}