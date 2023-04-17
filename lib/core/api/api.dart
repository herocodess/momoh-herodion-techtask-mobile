import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String get baseUrl => dotenv.env['BASE_URL'];
}
