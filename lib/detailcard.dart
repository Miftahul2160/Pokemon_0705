import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_data.dart';

class DetailCard extends StatefulWidget {
  final PokemonElement pokemon;
  const DetailCard({super.key, required this.pokemon});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    final primaryType = widget.pokemon.type.isNotEmpty
        ? typeValues.reverse[widget.pokemon.type.first] ?? ''
        : '';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Column(
          children: [
            Text(
              widget.pokemon.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.pokemon.id.toString().padLeft(3, "0"),
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [imageContainer(primaryType), SizedBox(height: 20), menu()],
        ),
      ),
    );
  }

  Widget imageContainer(String primaryType) {
    Color bg;
    switch (primaryType) {
      case 'Fire':
        bg = Color(0xFFEBBCB5);
        break;
      case 'Grass':
        bg = Color(0xFFC4E4D5);
        break;
      case 'Water':
        bg = Color(0xFFBDD4E7);
        break;
      default:
        bg = Colors.grey.shade200;
    }

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Image.network(widget.pokemon.img, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget menu() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMenuItems("Forms", true),
          SizedBox(width: 5),
          _buildMenuItems("Detail", false),
          SizedBox(width: 5),
          _buildMenuItems("Types", false),
          SizedBox(width: 5),
          _buildMenuItems("Stats", false),
          SizedBox(width: 5),
          _buildMenuItems("Weakness", false),
        ],
      ),
    );
  }

  Widget _buildMenuItems(String title, bool isSelected) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: isSelected ? Colors.black : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}