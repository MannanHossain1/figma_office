import 'package:flutter_codebase/core/exported_files/exported_file.dart';

class AppRoute {
  final Widget Function() page;
  final Bindings? binding;

  AppRoute({required this.page, this.binding});
}
