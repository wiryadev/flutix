part of 'services.dart';

class TransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(FlutixTransaction transaction) async {
    await transactionCollection.document().setData({
      'userId': transaction.userId,
      'title': transaction.title,
      'subtitle': transaction.subtitle,
      'time': transaction.time.millisecondsSinceEpoch,
      'amount': transaction.amount,
      'picture': transaction.picture,
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userId) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();

    var documents = snapshot.documents
        .where((document) => document.data['userId'] == userId);

    return documents
        .map(
          (doc) => FlutixTransaction(
            userId: doc.data['userId'],
            title: doc.data['title'],
            subtitle: doc.data['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(doc.data['time']),
            amount: doc.data['amount'],
            picture: doc.data['picture'],
          ),
        )
        .toList();
  }
}
