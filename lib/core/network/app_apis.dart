class AppApis {
  AppApis._();
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "9d7f94be913eddf2db40e317d2f12f36";

  static const String popularMovies = "3/movie/popular";
  static const String topRatedMovies = "3/movie/top_rated";
  static const String upcomingMovies = "3/movie/upcoming";
  static const String searchMovies = "3/search/movie";

  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  static String movieDetails(int movieId) => "/3/movie/$movieId";
  static String similarMovies(int movieId) => "/3/movie/$movieId/similar";

  static String imageUrl(String path) => "$imageBaseUrl$path";
}
