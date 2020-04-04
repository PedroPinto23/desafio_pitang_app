import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String id;
  final String url;

  DetailScreen({
    this.name,
    this.id,
    this.url,
  });

  Future<Map<String, dynamic>> getDetails(String id) async {
    http.Response res = await http
        .get("https://desafio-mobile-pitang.herokuapp.com/movies/detail/$id");
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: GoogleFonts.bowlbyOneSC(color: Colors.orange, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Image.network(
              "https://i.pinimg.com/564x/0f/56/88/0f56889a0799bf62793fcd17b5da7062.jpg",
              fit: BoxFit.cover,
              height: 700,
            ),
            FutureBuilder<Map>(
              future: getDetails(id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.transparent,
                            elevation: 20,
                            child: Hero(
                              tag: id,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: snapshot.data['url'],
                                    width: 250,
                                    height: 350,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 20,
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "Sinopse: \n" + snapshot.data['description'],
                                style: GoogleFonts.cinzel(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
