class Produto {
  final String id;
  String nome;
  String categoria;
  double preco;
  int quantidade;

  Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.quantidade,
  });

  // Converte os dados do Firestore em um objeto Produto.
  factory Produto.fromMap(String id, Map<String, dynamic> dados) {
    return Produto(
      id: id,
      nome: dados['nome'] as String? ?? '',
      categoria: dados['categoria'] as String? ?? '',
      preco: (dados['preco'] as num? ?? 0).toDouble(),
      quantidade: (dados['quantidade'] as num? ?? 0).toInt(),
    );
  }

  // Converte o objeto Produto em dados para salvar no Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'categoria': categoria,
      'preco': preco,
      'quantidade': quantidade,
    };
  }
}
