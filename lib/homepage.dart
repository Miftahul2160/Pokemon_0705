import 'package:flutter/material.dart';
import 'package:pokemon/detailcard.dart';
import 'package:pokemon/model/pokemon_data.dart';
import 'package:pokemon/service/pokemon_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchNamectr = TextEditingController();
  final PokemonService pokemonService = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              headerArea(),
              SizedBox(height: 20),
              searchBar(),
              SizedBox(height: 10),
              Expanded(child: pokemonList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget pokemonList() {
    return FutureBuilder<Pokemon>(
      future: pokemonService.getAllPokemon(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final list = snapshot.data?.pokemon ?? [];

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final p = list[index];
            final primaryType = p.type.isNotEmpty ? typeValues.reverse[p.type.first] ?? '' : '';
            final bg = _colorForType(primaryType);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailCard(pokemon: p)),
                );
              },
              child: Card(
                color: bg,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Image.network(p.img, fit: BoxFit.contain)),
                      SizedBox(height: 8),
                      Text(
                        p.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      SizedBox(height: 4),
                      Text(
                        p.id.toString().padLeft(3, '0'),
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _colorForType(String type) {
    switch (type) {
      case 'Fire':
        return Colors.redAccent.shade100;
      case 'Water':
        return Colors.blueAccent.shade100;
      case 'Grass':
        return Colors.greenAccent.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Widget headerArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pokédex",
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        ),
        Text(
          "Search for a Pokémon by name or using its National Pokédex number.",
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchNamectr,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: "Name or number",
              prefixIcon: Icon(Icons.search, color: Color(0xFF5D5E7B)),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color(0xFF5C5E7B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.filter_list, color: Colors.white),
        ),
      ],
    );
  }
}
