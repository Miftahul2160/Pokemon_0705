import 'package:flutter/material.dart';
import 'package:pokemon/detailcard.dart';
import 'package:pokemon/model/dummy_data.dart';
import 'package:pokemon/model/pokemon_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Pokedex',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Search for a pokemon by name or using its National Pokedex number.',
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              TextField(
                controller: searchNameController,
                decoration: InputDecoration(
                  hintText: 'Name or number',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: dummyPokemonsList.length,
                    itemBuilder: (context, index) {
                      final pokemon = dummyPokemonsList[index];
                      return listPokemon(context, pokemon);
                    },
                  
              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listPokemon(BuildContext context, PokemonData pokemon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailCard(pokemon: pokemon)),
        );
      },
      child: Card(
        color: pokemon.type == 'Fire'
            ? Colors.redAccent.shade100
            : pokemon.type == 'Water'
            ? Colors.blueAccent.shade100
            : pokemon.type == 'Grass'
            ? Colors.greenAccent.shade100
            : Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(pokemon.imageUrl, fit: BoxFit.contain),
              SizedBox(height: 10),
              Text(
                pokemon.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 2),
              Text(
                pokemon.id.toString(),
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
