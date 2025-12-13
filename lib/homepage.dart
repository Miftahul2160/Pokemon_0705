import 'package:flutter/material.dart';
import 'package:pokemon/model/dummy_data.dart';

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
              const Text(
                'Pokedex',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const Text(
                'Search for a pokemon by name or using its National Pokedex number.',
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    ), 
                  itemCount: dummyPokemonsList.length,  
                  itemBuilder: (context, index) {
                    final pokemon =  dummyPokemonsList[index];

                    return GestureDetector(
                      onTap: () => print('Tapped on ${pokemon.name}'),
                    );
                  }
                    ))
              ],
          ),
        ),
      ),
    );
  }
}
