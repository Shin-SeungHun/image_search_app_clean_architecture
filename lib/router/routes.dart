import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/model/image_item.dart';
import '../di/di_setup.dart';
import '../ui/detail/detail_screen.dart';
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
    GoRoute(
        path: '/detailScreen',
        builder: (context, state) {
          final imageItem = state.extra as ImageItem;
          return DetailScreen(imageItem: imageItem);
        }),
  ],
);
