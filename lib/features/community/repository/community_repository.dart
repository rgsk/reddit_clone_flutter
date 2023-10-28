import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_clone_flutter/core/constants/firebase_constants.dart';
import 'package:reddit_clone_flutter/core/failure.dart';
import 'package:reddit_clone_flutter/core/providers/firebase_providers.dart';
import 'package:reddit_clone_flutter/core/type_defs.dart';
import 'package:reddit_clone_flutter/models/community_model.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.read(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;

  CommunityRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid createCommunity(CommunityModel communityModel) async {
    try {
      final communityDoc = await _communities.doc(communityModel.name).get();
      if (communityDoc.exists) {
        throw 'Community with same name already exists!';
      }
      return right(
        _communities.doc(communityModel.name).set(
              communityModel.toMap(),
            ),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CommunityModel>> getUserCommunities(String uid) {
    return _communities
        .where(
          'members',
          arrayContains: uid,
        )
        .snapshots()
        .map((event) {
      List<CommunityModel> communities = [];
      for (final doc in event.docs) {
        communities.add(CommunityModel.fromMap(doc.data() as dynamic));
      }
      return communities;
    });
  }

  Stream<CommunityModel> getCommunityByName(String name) {
    return _communities
        .doc(name)
        .snapshots()
        .map((event) => CommunityModel.fromMap(
              event.data() as dynamic,
            ));
  }

  CollectionReference get _communities => _firestore.collection(
        FirebaseConstants.communitiesCollection,
      );
}
