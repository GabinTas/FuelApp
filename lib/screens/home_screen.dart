import 'package:flutter/material.dart';
import '../models/station.dart';
import '../services/fuel_api.dart';

class MyFuelApp extends StatefulWidget {
  const MyFuelApp({super.key, required this.title});
  final String title;

  @override
  State<MyFuelApp> createState() => _MyFuelApp();
}

class _MyFuelApp extends State<MyFuelApp> {
  Future<List<Station>>? _stationsFuture; // (1)
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ville = TextEditingController();
  String _carburantChoisi = 'e10';

  @override
  void dispose() {
    _ville.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _stationsFuture = GetStation.fetchStations(_ville.text, _carburantChoisi);
      });
    }
  }

  @override
  void initState() {
    super.initState(); // (2)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // (3)
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _ville,
                    decoration: const InputDecoration(
                      labelText: 'Ville',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez écrire le nom de la ville';
                      }
                      return null; // (4)
                    },
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>( // (5)
                    initialValue: _carburantChoisi,
                    decoration: const InputDecoration(
                      labelText: 'Carburant',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'gazole', child: Text('Gazole')),
                      DropdownMenuItem(value: 'sp95', child: Text('SP95')),
                      DropdownMenuItem(value: 'e10', child: Text('SP95-E10')),
                      DropdownMenuItem(value: 'sp98', child: Text('SP98')),
                      DropdownMenuItem(value: 'e85', child: Text('E85')),
                      DropdownMenuItem(value: 'gplc', child: Text('GPLc')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _carburantChoisi = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Soumettre'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (_stationsFuture != null) // (6)
              Expanded(
                child: StationResults(stationsFuture: _stationsFuture!),
              ),
          ],
        ),
      ),
    );
  }
}

class StationResults extends StatelessWidget {
  const StationResults({super.key, required this.stationsFuture});
  final Future<List<Station>> stationsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Station>>(
      future: stationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }
        final stations = snapshot.data!;
        if (stations.isEmpty) {
          return const Center(child: Text('Aucune station trouvée.'));
        }
        return ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            return Card(
              margin: const EdgeInsets.all(18),
              elevation: 10,
              color: Colors.blueGrey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.blue, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.adresse,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('${station.ville} - ${station.cp}'),
                    const SizedBox(height: 8),
                    Text(
                      station.prix != null ? '${station.prix} €': 'N/A',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      station.rupture_stock ? 'Rupture (${station.rupture_type})' : 'Disponible',
                      style: TextStyle(
                        color: station.rupture_stock ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}