import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/produto_mock.dart';

class ProdutoListScreen extends StatelessWidget {
  const ProdutoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque Fácil'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: produtosMock.length,
        itemBuilder: (context, index) {
          final produto = produtosMock[index];

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
