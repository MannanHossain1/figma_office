import '../../config/api_keys/translation_api_config.dart';
import '../../exported_files/exported_file.dart';

class TranslatorService extends GetxService {
  static TranslatorService get instance => Get.find<TranslatorService>();

  final ApiService _apiService = Get.find<ApiService>();

  final Map<String, String> _cache = {};

  final Map<String, Future<String>> _pending = {};

  static const String _cacheStorageKey = 'translator_cache';
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadCache();
  }

  void _loadCache() {
    final stored = _storage.read<Map<String, dynamic>>(_cacheStorageKey);
    if (stored != null) {
      _cache.addAll(stored.map((k, v) => MapEntry(k, v.toString())));
      DService().info(
        'TranslatorService: loaded ${_cache.length} cached translations',
      );
    }
  }

  void _persistCache() {
    _storage.write(_cacheStorageKey, _cache);
  }

  String _cacheKey(String text, String targetLang) => '$text|$targetLang';

  String? getCached(String text, String targetLang) {
    return _cache[_cacheKey(text, targetLang)];
  }

  final Map<String, Rx<String>> _reactive = {};

  /// Returns an observable that holds the translated text for [text] in [targetLang].
  /// Use with Obx in the UI; updates when translation is fetched.
  Rx<String> watchTranslated(String text, String targetLang) {
    final key = _cacheKey(text, targetLang);
    if (_reactive.containsKey(key)) return _reactive[key]!;
    final initial = getCached(text, targetLang) ?? text;
    final rx = initial.obs;
    _reactive[key] = rx;
    if (initial == text && targetLang != TranslationApiConfig.sourceLanguage) {
      translate(text, to: targetLang).then((translated) {
        rx.value = translated;
      });
    }
    return rx;
  }

  Future<String> translate(
    String text, {
    String from = 'ar',
    String to = 'en',
  }) async {
    if (text.trim().isEmpty) return text;

    if (to == TranslationApiConfig.sourceLanguage) return text;

    final key = _cacheKey(text, to);

    if (_cache.containsKey(key)) return _cache[key]!;

    if (_pending.containsKey(key)) return _pending[key]!;

    final future = _fetchTranslation(text, from: from, to: to, cacheKey: key);
    _pending[key] = future;

    try {
      return await future;
    } finally {
      _pending.remove(key);
    }
  }

  void clearCache() {
    _cache.clear();
    _pending.clear();
    _reactive.clear();
    _storage.remove(_cacheStorageKey);
    DService().info('TranslatorService: cache cleared');
  }

  Future<String> _fetchTranslation(
    String text, {
    required String from,
    required String to,
    required String cacheKey,
  }) async {
    try {
      final url =
          '${TranslationApiConfig.baseUrl}?key=${TranslationApiConfig.apiKey}';

      final response = await _apiService.postData(
        url: url,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: {'q': text, 'source': from, 'target': to, 'format': 'text'},
      );

      if (response.isSuccess && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final translations = data['data']?['translations'] as List<dynamic>?;
        final translated = translations?.isNotEmpty == true
            ? translations!.first['translatedText'] as String?
            : null;

        if (translated == null || translated.isEmpty) {
          DService().warning(
            'TranslatorService: translation missing in API response',
          );
          return text;
        }

        _cache[cacheKey] = translated;
        _persistCache();

        return translated;
      }

      DService().error(
        'TranslatorService: API returned ${response.statusCode} - ${response.message}',
      );
      return text;
    } catch (e) {
      DService().error('TranslatorService: translation failed - $e');
      return text;
    }
  }
}
