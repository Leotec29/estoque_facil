import 'package:flutter/material.dart';

import '../../data/repositories/produto_firestore_repository.dart';
import '../../domain/produto.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;

  const ProdutoFormScreen({super.key, this.produto});

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  final ProdutoFirestoreRepository _repository = ProdutoFirestoreRepository();

  bool _salvando = false;

  bool get _editando => widget.produto != null;

  @override
  void initState() {
    super.initState();

    final produto = widget.produto;

    if (produto != null) {
      _nomeController.text = produto.nome;
      _categoriaController.text = produto.categoria;
      _precoController.text = produto.preco.toStringAsFixed(2);
      _quantidadeController.text = produto.quantidade.toString();
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _precoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _salvarProduto() async {
    if (_salvando) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _salvando = true;
    });

    try {
      final produto = Produto(
        id: widget.produto?.id ?? '',
        nome: _nomeController.text.trim(),
        categoria: _categoriaController.text.trim(),
        preco: double.parse(_precoController.text.trim().replaceAll(',', '.')),
        quantidade: int.parse(_quantidadeController.text.trim()),
      );

      if (_editando) {
        await _repository.atualizarProduto(produto);
      } else {
        await _repository.adicionarProduto(produto);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Produto atualizado com sucesso!'
                : 'Produto cadastrado com sucesso!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).pop();
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível salvar o produto. Verifique sua conexão e tente novamente.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Produto' : 'Novo Produto'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Icon(_editando ? Icons.edit : Icons.add_box, size: 70),
            const SizedBox(height: 16),
            Text(
              _editando ? 'Editar produto' : 'Cadastrar produto',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _editando
                  ? 'Altere os dados do produto abaixo.'
                  : 'Preencha os dados abaixo para adicionar um novo produto.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _nomeController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nome do produto',
                hintText: 'Ex.: Martelo',
                prefixIcon: Icon(Icons.inventory_2),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite o nome do produto.';
                }

                if (value.trim().length < 2) {
                  return 'Digite um nome válido.';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _categoriaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                hintText: 'Ex.: Ferramentas',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite a categoria.';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _precoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço',
                hintText: 'Ex.: 49,90',
                prefixText: 'R\$ ',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite o preço.';
                }

                final preco = double.tryParse(
                  value.trim().replaceAll(',', '.'),
                );

                if (preco == null || preco <= 0) {
                  return 'Digite um preço válido.';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade em estoque',
                hintText: 'Ex.: 10',
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite a quantidade.';
                }

                final quantidade = int.tryParse(value.trim());

                if (quantidade == null || quantidade < 0) {
                  return 'Digite uma quantidade válida.';
                }

                return null;
              },
            ),
            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _salvando ? null : _salvarProduto,
                icon: _salvando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _salvando
                      ? 'Salvando...'
                      : _editando
                      ? 'Salvar alterações'
                      : 'Cadastrar produto',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
