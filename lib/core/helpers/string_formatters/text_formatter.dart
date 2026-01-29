class TextFormatter {
  static String display(String value) {
    return value.replaceAll("_", " ");
  }

  static String original(String value) {
    return value.replaceAll(" ", "_");
  }
}
