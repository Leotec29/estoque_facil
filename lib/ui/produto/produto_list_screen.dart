import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/produto_firestore_repository.dart';
import '../../domain/produto.dart';

class ProdutoListScreen extends StatefulWidget {
  const ProdutoListScreen({super.key});

  @override
  State<ProdutoListScreen> createState() => _ProdutoListScreenState();
}

class _ProdutoListScreenState extends State<ProdutoListScreen> {
  final ProdutoFirestoreRepository _repository = ProdutoFirestoreRepository();

  late final Stream<List<Produto>> _produtosStream;

  @override
  void initState() {
    super.initState();
    _produtosStream = _repository.listarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque Fácil'), centerTitle: true),
      body: StreamBuilder<List<Produto>>(
        stream: _produtosStream,
        builder: (context, snapshot) {
          // Carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Erro
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Não foi possível carregar os produtos.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Verifique sua conexão e tente novamente.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _produtosStream = _repository.listarProdutos();
                        });
                      },
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final produtos = snapshot.data ?? [];

          // Lista vazia
          if (produtos.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.inventory_2_outlined,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Seu estoque está vazio!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Cadastre seu primeiro produto para começar.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/produto/novo');
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Cadastrar produto'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Lista de produtos
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
                  title: Text(
                    produto.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${produto.categoria} • Estoque: ${produto.quantidade}',
                  ),
                  trailing: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  onTap: () {
                    context.push('/produto/${produto.id}');
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/produto/novo');
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo produto'),
      ),
    );
  }
}
