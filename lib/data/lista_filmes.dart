class Filmes {
  final String id;
  final String name;
  final String url;
  Filmes({this.id, this.name, this.url});

  factory Filmes.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Filmes(
      id: json['_id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "url": url,
    };
  }
}
