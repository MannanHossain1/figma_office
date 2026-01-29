class BaseAssetsPath {
  BaseAssetsPath.internal();

  static const String _bPath = "assets";

  static String imagePath(String path) => "$_bPath/images/$path";
  static String iconPth(String path) => "$_bPath/icons/$path";
}
