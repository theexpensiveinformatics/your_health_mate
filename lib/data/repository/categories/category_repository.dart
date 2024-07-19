import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart%20%20';

import '../../../features/help/models/category/categories_model_tabs.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();


  /// -- variables
  final _db = FirebaseFirestore.instance;

  /// -- get all categories
  Future<List<CategoryModelTabs>>getAllCategories() async{
    try{
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs.map((document)=>CategoryModelTabs.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch(e){
      throw YHMFirebaseException(e.code).message;
    }on YHMPlatformException catch(e){
      throw YHMPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong, Please Try again';
    }
  }

}