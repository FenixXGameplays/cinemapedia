import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env["THE_MOVIEDB_KEY"] ?? "No hay api key";
  static String posterNotFound = 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg';
}