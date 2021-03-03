part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    } else {
      var data = json.decode(response.body);
      List results = data['results'];

      return results.map((result) => Movie.fromJson(result)).toList();
    }
  }

  static Future<MovieDetail> getDetail(Movie movie,
      {http.Client client}) async {
    print('Test Services getDetail: ' + movie.title);
    String url =
        'https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'id':
        language = 'Indonesia';
        break;
      case 'en':
        language = 'English';
        break;
      case 'ja':
        language = 'Japanese';
        break;
      case 'ko':
        language = 'Korean';
        break;
      default:
        language = 'Unknown';
    }

    print('Test Services getDetail: ' + genres.toString());
    print('Test Services getDetail: ' + language);
    return MovieDetail(
      movie,
      language: language,
      genres: genres
          .map(
            (genre) => (genre as Map<String, dynamic>)['name'].toString(),
          )
          .toList(),
    );
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    print('Test Services getDetail: ' + data.toString());

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map(
          (cast) => Credit(
            name: (cast as Map<String, dynamic>)['name'],
            profilePath: (cast as Map<String, dynamic>)['profile_path'],
          ),
        )
        .take(8)
        .toList();
  }
}
