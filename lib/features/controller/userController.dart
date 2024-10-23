import 'package:arcitech/core/model/userModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserNotifier extends Notifier<AppUser?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  AppUser? build() {
    // Initialize the state with the current user if logged in
    User? user = _auth.currentUser;
    if (user != null) {
      _loadUserData(user.uid);
      return AppUser(uid: user.uid, email: user.email);
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': '',
          'photoURL': '',
        });
        state = AppUser(uid: user.uid, email: user.email);
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        _loadUserData(user.uid);
        state = AppUser(uid: user.uid, email: user.email);
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _loadUserData(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      state = state?.copyWith(
        displayName: doc['name'],
        photoURL: doc['photoURL'],
      );
    }
  }

  Future<void> updateUserProfile(String displayName) async {
    if (state != null) {
      await _firestore.collection('users').doc(state!.uid).update({
        'name': displayName,
      });
      state = state?.copyWith(displayName: displayName);
    }
  }

  Future<void> pickAndUploadImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null && state != null) {
        String filePath = 'user_photos/${state!.uid}/${pickedFile.name}';
        UploadTask uploadTask =
            _storage.ref().child(filePath).putFile(File(pickedFile.path));

        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();

        await _firestore.collection('users').doc(state!.uid).update({
          'photoURL': downloadURL,
        });

        state = state?.copyWith(photoURL: downloadURL);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

final userProvider = NotifierProvider<UserNotifier, AppUser?>(() {
  return UserNotifier();
});
