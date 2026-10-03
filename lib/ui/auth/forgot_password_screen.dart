import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  bool _carregando = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _recuperarSenha() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _carregando = true;
    });

    try {
      await _authRepository.recuperarSenha(_emailController.text.trim());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'E-mail de recuperação enviado. Verifique sua caixa de entrada.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      String mensagem = 'Não foi possível enviar o e-mail.';

      final erro = e.toString();

      if (erro.contains('invalid-email')) {
        mensagem = 'Digite um e-mail válido.';
      } else if (erro.contains('user-not-found')) {
        mensagem = 'Não encontramos uma conta com esse e-mail.';
      } else if (erro.contains('network-request-failed')) {
        mensagem = 'Verifique sua conexão com a internet.';
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensagem)));
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_reset, size: 80),
                const SizedBox(height: 16),
                const Text(
                  'Esqueci minha senha',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Digite seu e-mail e enviaremos um link para você criar uma nova senha.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Digite seu e-mail.';
                    }

                    if (!valor.contains('@')) {
                      return 'Digite um e-mail válido.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _carregando ? null : _recuperarSenha,
                  child: _carregando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Enviar e-mail'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _carregando
                      ? null
                      : () {
                          context.go('/login');
                        },
                  child: const Text('Voltar para o login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
