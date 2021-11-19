import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_maintenance/auth/signup/model/UserModel.dart';

CollectionReference<userModel>getUserCollectionsWithConvert() {
  return FirebaseFirestore.instance
      .collection(userModel.Collection_Name)
      .withConverter<userModel>(
        fromFirestore: (snapshot, _) => userModel.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );
}
