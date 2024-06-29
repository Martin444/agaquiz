// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class AqFunctions {
  static void changePageTitle(String newTitle) {
    html.document.title = newTitle;
  }
}
