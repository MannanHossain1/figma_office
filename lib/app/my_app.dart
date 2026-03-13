import '../core/app_routes/app_route_pages.dart';
import '../core/exported_files/exported_file.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GetMaterialApp(
      initialBinding: AppBindings(),
      initialRoute: AppRoutePaths.splashScreen,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightThemeData,
      builder: EasyLoading.init(),
      getPages: AppRoutePages.pages.entries
          .map(
            (entry) => GetPage(
              name: entry.key,
              page: entry.value.page,
              binding: entry.value.binding,
            ),
          )
          .toList(),
    );
  }
}
