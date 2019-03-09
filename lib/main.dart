import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemon_detail.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokedex",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://api.myjson.com/bins/ap002";
  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
    print("After fetch work");
  }

  fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("PokeDex"),
          backgroundColor: Colors.cyan,
        ),
        body: pokeHub == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 3,
                children: pokeHub.pokemon
                    .map((poke) => Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokeDetail(poke)));
                            },
                            child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img))),
                                    ),
                                    Text(poke.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ));
  }
}
