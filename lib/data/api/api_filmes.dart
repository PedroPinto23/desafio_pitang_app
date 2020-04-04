import 'package:pitang_app/data/lista_filmes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesApi {
  Future<List<Filmes>> getMovies(int page, int size) async {
    http.Response res = await http.get(
        "https://desafio-mobile-pitang.herokuapp.com/movies/list?page=$page&size=${size + 1}");
    return decode(res);
  }

  List<Filmes> decode(http.Response res) {
    if (res.statusCode == 200) {
      var decoded = json.decode(res.body);

      List<Filmes> filmes = decoded.map<Filmes>((f) {
        return Filmes.fromJson(f);
      }).toList();
      return filmes;
    } else {
      throw Exception("Erro ao carregar");
    }
  }
}
