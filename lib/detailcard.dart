import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_data.dart';

class DetailCard extends StatefulWidget {
  final PokemonData pokemon;
  const DetailCard({super.key, required this.pokemon});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}