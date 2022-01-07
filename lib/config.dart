import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Config {
  static String get serverUri {
    String uri = dotenv.env['SERVER_PROTOCOL']! + '://' + dotenv.env['SERVER_URL']!;

    if (dotenv.env['SERVER_PORT'] != null) {
      uri = uri + ':${dotenv.env['SERVER_PORT']}/';
    } else {
      uri = '$uri/';
    }

    return uri;
  }

  static init() async {
    return dotenv.load(fileName:'.env.chat');
  }
}
