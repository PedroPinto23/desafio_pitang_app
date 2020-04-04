import 'package:flutter/material.dart';
import 'package:pitang_app/data/api/api_filmes.dart';
import 'package:pitang_app/data/lista_filmes.dart';
import 'package:pitang_app/pages/custom_drawer.dart';
import 'package:pitang_app/pages/details_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool position = true;
  int page = 0;
  int size = 10;
  @override
  Widget build(BuildContext context) {
    MoviesApi api = MoviesApi();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MOVIES',
          style: GoogleFonts.blackOpsOne(
            color: Colors.orange,
            fontSize: 25,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.compare_arrows,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                position = !position;
              });
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Image.network(
            "https://i.pinimg.com/564x/0f/56/88/0f56889a0799bf62793fcd17b5da7062.jpg",
            fit: BoxFit.cover,
            height: 700,
          ),
          FutureBuilder<List<Filmes>>(
              future: api.getMovies(page, size),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text("Erro ao carregar os dados");
                    } else {
                      List data = snapshot.data;
                      return ListView.builder(
                        scrollDirection:
                            position ? Axis.vertical : Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          print(data.length);
                          print(data[index]);
                          return index + 1 < data.length
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          name: data[index].name,
                                          id: data[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Column(
                                      children: <Widget>[
                                        Card(
                                          color: Colors.transparent,
                                          elevation: 20,
                                          child: Container(
                                              margin: EdgeInsets.all(8),
                                              child: Hero(
                                                tag: data[index].id,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                    placeholder:
                                                        kTransparentImage,
                                                    image: data[index].url,
                                                    width: 250,
                                                    height: 350,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Card(
                                          elevation: 20,
                                          child: Text(
                                            data[index].name,
                                            style: GoogleFonts.bowlbyOneSC(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize:
                                                    data[index].name.length > 30
                                                        ? 15
                                                        : 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Divider(
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  child: position
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 38,
                                              ),
                                              disabledColor: Colors.transparent,
                                              onPressed: page > 0
                                                  ? () {
                                                      setState(() {
                                                        page--;
                                                      });
                                                    }
                                                  : null,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 38,
                                              ),
                                              disabledColor: Colors.transparent,
                                              onPressed: page < 2
                                                  ? () {
                                                      setState(() {
                                                        page++;
                                                      });
                                                    }
                                                  : null,
                                            )
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                              ),
                                              disabledColor: Colors.black,
                                              onPressed: page > 0
                                                  ? () {
                                                      setState(() {
                                                        page--;
                                                      });
                                                    }
                                                  : null,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              ),
                                              disabledColor: Colors.black,
                                              onPressed: page < 2
                                                  ? () {
                                                      setState(() {
                                                        page++;
                                                      });
                                                    }
                                                  : null,
                                            )
                                          ],
                                        ),
                                );
                        },
                      );
                    }
                }
              }),
        ],
      ),
    );
  }
}
