import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart%20%20';
import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';


class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user record
  Future<void>saveUserRecord(UserModel user) async{
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }

  /// function to fetch user details
  Future<UserModel>fetchUserDetails()async{
    try{
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }}on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on YHMFormateException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }

  ///Update User Deatils
  Future<void>updateUserDetails(UserModel updatedUser)async{
    try{
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }

  /// Update single field of user details
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      print('Firebase Exception: ${e.message}');
      throw YHMFirebaseException(e.code).message;
    } on YHMFormateException catch (_) {
      print('Format Exception');
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      print('Platform Exception: ${e.message}');
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      print('Unexpected Error: $e');
      throw 'something went wrong. Please try again';
    }
  }


  /// Function to remove user data from firestore
  Future<void>removeUserRecord(String userId) async{
    try{
      await _db.collection("Users").doc(userId).delete();
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }

  /// New added - for updating last login time
  Future<void>  updateLastLoginTime(String userId) async {
    try{
      await _db.collection("Users").doc(userId).update({'LastLoginTime': DateTime.now()});
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }



  // get user role
  Future<String> getUserRole(String userId) async {
    try {
      final user = await _db.collection('Users').doc(userId).get();

      // Check if user data is available
      if (user.exists) {
        // User data is available, return the role
        return user.get('role');
      } else {
        // User data is not available, return a default value
        return 'user';
      }
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on YHMFormateException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }

  ///uplaod image
  Future<String> uploadImage(String path, XFile image) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }


  ///upload File
  Future<String> uploadFile(String path, XFile file) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(file.name);
      await ref.putFile(File(file.path));
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseException catch (e){
      throw YHMFirebaseException(e.code).message;
    }on YHMFormateException catch(_){
      throw const YHMFormateException();
    }on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    }catch (e){
      throw 'something went wrong. Please try again';
    }
  }



}