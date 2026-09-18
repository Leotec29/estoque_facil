import 'package:go_router/go_router.dart';

import '../ui/home/home_screen.dart';
import '../ui/produto/produto_detail_screen.dart';
import '../ui/produto/produto_form_screen.dart';
import '../ui/produto/produto_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/produtos',
      builder: (context, state) => const ProdutoListScreen(),
    ),

    GoRoute(
      path: '/produto/novo',
      builder: (context, state) => const ProdutoFormScreen(),
    ),

    GoRoute(
      path: '/produto/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return ProdutoDetailScreen(produtoId: id);
      },
    ),
  ],
);
