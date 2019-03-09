import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(pokemon.name),
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Text(pokemon.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      )),
                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                              label: Text(t,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onSelected: (b) {},
                              backgroundColor: Colors.deepPurpleAccent,
                            ))
                        .toList(),
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((w) => FilterChip(
                              backgroundColor: Colors.red,
                              onSelected: (b) {},
                              label: Text(w,
                                  style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution
                            ?.map((evo) => FilterChip(
                                  backgroundColor: Colors.green,
                                  onSelected: (b) {},
                                  label: Text(
                                    evo.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            ?.toList() ??
                        [Text("No more evolutions")],
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Hero(
                  tag: pokemon.img,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(pokemon.img), fit: BoxFit.cover),
                    ),
                  )))
        ],
      ),
    );
  }
}
