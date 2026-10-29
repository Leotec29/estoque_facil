import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:estoque_facil/domain/produto.dart';

class ProdutoFirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Retorna a coleção de produtos do usuário autenticado.
  CollectionReference<Map<String, dynamic>> get _colecaoProdutos {
    final usuario = _auth.currentUser;

    if (usuario == null) {
      throw StateError('Usuário não autenticado.');
    }

    return _firestore
        .collection('users')
        .doc(usuario.uid)
        .collection('products');
  }

  // READ: acompanha os produtos em tempo real.
  Stream<List<Produto>> listarProdutos() {
    try {
      return _colecaoProdutos.snapshots().map((snapshot) {
        return snapshot.docs.map((documento) {
          return Produto.fromMap(documento.id, documento.data());
        }).toList();
      });
    } catch (erro) {
      return Stream.error(erro);
    }
  }

  // CREATE: cadastra um novo produto.
  Future<void> adicionarProduto(Produto produto) async {
    await _colecaoProdutos.add({
      ...produto.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // UPDATE: atualiza um produto existente.
  Future<void> atualizarProduto(Produto produto) async {
    await _colecaoProdutos.doc(produto.id).update({
      ...produto.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // DELETE: exclui um produto.
  Future<void> excluirProduto(String id) async {
    await _colecaoProdutos.doc(id).delete();
  }
}
