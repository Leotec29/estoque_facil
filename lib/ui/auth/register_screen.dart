import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  bool _carregando = false;
  bool _mostrarSenha = false;
  bool _mostrarConfirmacao = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _carregando = true;
    });

    try {
      await _authRepository.cadastrar(
        email: _emailController.text.trim(),
        senha: _senhaController.text,
      );

      if (!mounted) return;

      context.go('/');
    } catch (e) {
      if (!mounted) return;

      String mensagem = 'Não foi possível criar a conta.';

      final erro = e.toString();

      if (erro.contains('email-already-in-use')) {
        mensagem = 'Este e-mail já está cadastrado.';
      } else if (erro.contains('invalid-email')) {
        mensagem = 'Digite um e-mail válido.';
      } else if (erro.contains('weak-password')) {
        mensagem = 'A senha é muito fraca.';
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
      appBar: AppBar(title: const Text('Criar conta'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.person_add, size: 70),
                const SizedBox(height: 16),
                const Text(
                  'Criar sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  obscureText: !_mostrarSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _mostrarSenha = !_mostrarSenha;
                        });
                      },
                      icon: Icon(
                        _mostrarSenha ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Digite uma senha.';
                    }

                    if (valor.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: !_mostrarConfirmacao,
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _mostrarConfirmacao = !_mostrarConfirmacao;
                        });
                      },
                      icon: Icon(
                        _mostrarConfirmacao
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Confirme sua senha.';
                    }

                    if (valor != _senhaController.text) {
                      return 'As senhas não coincidem.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _carregando ? null : _cadastrar,
                  child: _carregando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Criar conta'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _carregando
                      ? null
                      : () {
                          context.go('/login');
                        },
                  child: const Text('Já tenho uma conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
