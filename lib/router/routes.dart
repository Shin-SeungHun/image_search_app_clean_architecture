import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../di/di_setup.dart';
import '../ui/main/main_screen.dart';
import '../ui/main/main_view_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider.value(
        value: getIt<MainViewModel>(),
        child: const MainScreen(),
      ),
    ),
  ],
);
