import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repositories/produto_firestore_repository.dart';
import '../../domain/produto.dart';
import 'produto_form_screen.dart';

class ProdutoDetailScreen extends StatefulWidget {
  final String produtoId;

  const ProdutoDetailScreen({super.key, required this.produtoId});

  @override
  State<ProdutoDetailScreen> createState() => _ProdutoDetailScreenState();
}

class _ProdutoDetailScreenState extends State<ProdutoDetailScreen> {
  final ProdutoFirestoreRepository _repository = ProdutoFirestoreRepository();

  bool _excluindo = false;

  Future<void> _excluirProduto() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir produto'),
        content: const Text(
          'Tem certeza de que deseja excluir este produto? '
          'Essa ação não poderá ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;

    setState(() {
      _excluindo = true;
    });

    try {
      await _repository.excluirProduto(widget.produtoId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto excluído com sucesso!'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      context.pop();
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível excluir o produto.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _excluindo = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final produtoRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_usuarioId)
        .collection('products')
        .doc(widget.produtoId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        actions: [
          IconButton(
            tooltip: 'Excluir produto',
            onPressed: _excluindo ? null : _excluirProduto,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: produtoRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar o produto.'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Produto não encontrado.'));
          }

          final produto = Produto.fromMap(
            snapshot.data!.id,
            snapshot.data!.data()!,
          );

          return _conteudoProduto(produto);
        },
      ),
    );
  }

  String get _usuarioId {
    return FirebaseFirestore.instance.app.options.projectId.isNotEmpty
        ? _uidAtual
        : '';
  }

  String get _uidAtual {
    return _firebaseUid;
  }

  String get _firebaseUid {
    // O UID vem da sessão autenticada.
    return _authAtual;
  }

  String get _authAtual {
    return _usuarioAutenticado;
  }

  String get _usuarioAutenticado {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Widget _conteudoProduto(Produto produto) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Icon(Icons.inventory_2, size: 90)),
          const SizedBox(height: 24),
          Text(
            produto.nome,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            'Categoria: ${produto.categoria}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          Text(
            'Preço: R\$ ${produto.preco.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          Text(
            'Estoque: ${produto.quantidade} unidades',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          Text('ID: ${produto.id}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdutoFormScreen(produto: produto),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar produto'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: _excluindo ? null : _excluirProduto,
              icon: _excluindo
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              label: Text(_excluindo ? 'Excluindo...' : 'Excluir produto'),
            ),
          ),
        ],
      ),
    );
  }
}
