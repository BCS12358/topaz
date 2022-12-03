import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topaz/models/client/client.dart';
import 'package:topaz/services/database_service.dart';

class ClientDBService {
  late DatabaseService _databaseService;
  final String uid;

  static const String _collectionName = 'clients';

  ClientDBService({required this.uid}) {
    _databaseService = DatabaseService(uid: uid);
  }

  Stream<List<Client>> messagetListStream() {
    return _databaseService.userRef.collection(_collectionName).snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (messageListSnapshot) => Client.fromJson(
                  messageListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  Future addClient({required Client client}) async {
    final clientRef =
        _databaseService.userRef.collection(_collectionName).doc();

    client.id = clientRef.id;

    WriteBatch batch = _databaseService.database.batch();

    batch.set(clientRef, client.toJson(), SetOptions(merge: false));

    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMessage(Client client) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final clientRef =
        _databaseService.userRef.collection(_collectionName).doc(client.id);
    batch.delete(clientRef);
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
