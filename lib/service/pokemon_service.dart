import 'package:http/http.dart' as http;
import 'package:pokemon/model/pokemon_data.dart';

class PokemonService {
  final String baseUrl = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<Pokemon> getAllPokemon() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final pokemonRespon = Pokemon.fromJson(response.body);
      return pokemonRespon;
    } else {
      throw Exception('Failed to load Pokemon data');
    }
  }
}
