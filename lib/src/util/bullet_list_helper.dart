import 'dart:convert';

class BulletListHelper {
  static convertTextToList(String text) {
    LineSplitter lineSplitter = LineSplitter();

    return lineSplitter.convert(text.trim());
  }

  static convertListToText(List<String> list) {
    StringBuffer buffer = StringBuffer();
    for (String line in list) {
      buffer.write(line);
      buffer.writeln();
    }

    return buffer.toString();
  }

  static String formatStringFromString(String text) {
    LineSplitter lineSplitter = LineSplitter();
    var list = lineSplitter.convert(text.trim());
    StringBuffer buffer = StringBuffer();
    for (String line in list) {
      if (!line.startsWith("• ")) {
        buffer.write("• ");
      }
      buffer.write(line);
      buffer.writeln();
    }

    return buffer.toString();
  }

  static String formatStringFromList(List<String> list) {
    StringBuffer buffer = StringBuffer();
    for (String line in list) {
      if (!line.startsWith("• ")) {
        buffer.write("• ");
      }
      buffer.write(line);
      buffer.writeln();
    }

    return buffer.toString();
  }

  static String formatRecipe(
    String introduction,
    List<String> ingredients,
    String instructions,
  ) {
    StringBuffer buffer = StringBuffer();

    buffer.write(introduction);
    buffer.writeln();
    buffer.write(formatStringFromList(ingredients));
    buffer.writeln();
    buffer.write(instructions);

    return buffer.toString();
  }
}
