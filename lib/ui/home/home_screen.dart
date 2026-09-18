import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/produto_mock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalProdutos = produtosMock.length;

    final totalEstoque = produtosMock.fold<int>(
      0,
      (total, produto) => total + produto.quantidade,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Estoque Fácil'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Olá! 👋',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Controle seu estoque de forma simples e organizada.',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.inventory_2, size: 30),
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Produtos cadastrados',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$totalProdutos',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.storage, size: 30),
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Itens em estoque',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$totalEstoque',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          FilledButton.icon(
            onPressed: () {
              context.push('/produtos');
            },
            icon: const Icon(Icons.inventory),
            label: const Text('Ver produtos'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              context.push('/produto/novo');
            },
            icon: const Icon(Icons.add),
            label: const Text('Cadastrar produto'),
          ),
        ],
      ),
    );
  }
}
