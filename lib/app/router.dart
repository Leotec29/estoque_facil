import 'auth_router_refresh.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/forgot_password_screen.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/register_screen.dart';
import '../ui/home/home_screen.dart';
import '../ui/produto/produto_detail_screen.dart';
import '../ui/produto/produto_form_screen.dart';
import '../ui/produto/produto_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: AuthRouterRefresh(),
  redirect: (context, state) {
    final usuario = FirebaseAuth.instance.currentUser;

    final estaNaTelaDeLogin = state.matchedLocation == '/login';
    final estaNaTelaDeCadastro = state.matchedLocation == '/cadastro';
    final estaNaTelaDeRecuperacao = state.matchedLocation == '/esqueci-senha';

    final estaNaAutenticacao =
        estaNaTelaDeLogin || estaNaTelaDeCadastro || estaNaTelaDeRecuperacao;

    if (usuario == null && !estaNaAutenticacao) {
      return '/login';
    }

    if (usuario != null && estaNaAutenticacao) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/cadastro',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/esqueci-senha',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
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
