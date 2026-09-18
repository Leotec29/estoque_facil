import 'package:flutter/material.dart';

import '../../data/produto_mock.dart';

class ProdutoDetailScreen extends StatelessWidget {
  final String produtoId;

  const ProdutoDetailScreen({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    final produto = produtosMock.firstWhere(
      (produto) => produto.id == produtoId,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Produto')),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
