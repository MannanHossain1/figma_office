import 'package:b_potash/core/exported_files/exported_file.dart';

/// Simple logging wrapper so you can swap logger implementation later.
class DService {
  static final DService _instance = DService._internal();
  factory DService() => _instance;
  DService._internal();

  final Logger _logger = Logger();

  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message) => _logger.e(message);
}

