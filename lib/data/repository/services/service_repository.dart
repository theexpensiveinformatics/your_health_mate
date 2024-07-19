import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart%20%20';
import '../../../features/help/models/Service/book_service_model.dart';
import '../../../features/help/models/Service/service_creating_model.dart';
import '../../../features/help/models/Service/service_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ServiceRepository extends GetxController {
  static ServiceRepository get instance => Get.find();

  /// -- variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ServiceCreatingModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs.map((document) =>
          ServiceCreatingModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on YHMPlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please Try again';
    }
  }


  Future<List<ServiceCreatingModel>> fetchServices(String categoryId) async {
    try {
      DocumentSnapshot categoryDoc = await _db.collection('categories').doc(
          categoryId).get();
      Map<String, dynamic> categoryData = categoryDoc.data() as Map<
          String,
          dynamic>;
      List<dynamic> servicesData = categoryData['services'] ?? [];
      List<ServiceCreatingModel> services = servicesData.map((service) =>
          ServiceCreatingModel.fromSnapshot(service)).toList();
      return services;
    } catch (e) {
      print('Error fetching services: $e');
      return [];
    }
  }

  Future<void> bookServices(BookServiceModel bookServiceModel,
      String liveServiceId) async {
    try {
      DocumentReference docRef = await _db.collection('LiveServices').doc(
          liveServiceId).collection('Requests').add(bookServiceModel.toJson());
      await docRef.set({
        'bookServiceId': docRef.id,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on YHMFormateException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  /// Function to create services
  Future<void> createServices(ServiceModel serviceModel, String category,
      String subCategory, String warranty) async {
    try {
      DocumentReference docRef = await _db.collection('LiveServices').add(
          serviceModel.toJson());
      await docRef.set({
        'liveServiceId': docRef.id,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on YHMFormateException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  //get service name
  Future<String?> getServiceName(String categoryId, String serviceId) async {
    try {
      // Retrieve the document reference for the specified category
      DocumentReference categoryRef = _db.collection('categories').doc(
          categoryId);

      // Get the document snapshot for the category
      DocumentSnapshot categorySnapshot = await categoryRef.get();

      if (categorySnapshot.exists) {
        // Get the data as a map
        Map<String, dynamic> categoryData = categorySnapshot.data() as Map<
            String,
            dynamic>;

        // Get the services array
        List<dynamic> services = categoryData['services'] ?? [];

        // Find the service with the matching serviceId
        var selectedService = services.firstWhere(
              (service) => service['serviceId'] == serviceId,
          orElse: () => null,
        );

        // If the service is found, return the serviceName
        if (selectedService != null) {
          return selectedService['serviceName'];
        }
      }
    } catch (e) {
      print('Error retrieving serviceName: $e');
    }

    // Return null if serviceId is not found or any error occurs
    return null;
  }

  // get imageUrl
  Future<String?> getImageUrl(String categoryName) async {
    try {
      // Retrieve the collection reference for 'categories'
      CollectionReference categoriesRef = FirebaseFirestore.instance.collection('categories');

      // Query the collection for documents with the specified categoryName
      QuerySnapshot querySnapshot = await categoriesRef.where('category', isEqualTo: categoryName).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document with the matching categoryName, get the first document
        DocumentSnapshot categoryDoc = querySnapshot.docs.first;

        // Get the data as a map
        Map<String, dynamic> categoryData = categoryDoc.data() as Map<String, dynamic>;

        // Return the 'img' field
        return categoryData['img'];
      } else {
        print('No document found for the specified category name.');
      }
    } catch (e) {
      print('Error retrieving imageUrl: $e');
    }

    // Return null if the document is not found or any error occurs
    return null;
  }

  ///-- get services for creating services
  Future<List<ServiceCreatingModel>> getServicesForCategory(String category) async {
    try {
      DocumentSnapshot categoryDoc = await _db.collection('categories').doc(
          category).get();

      Map<String, dynamic> categoryData = categoryDoc.data() as Map<
          String,
          dynamic>;

      List<dynamic> servicesData = categoryData['services'] ?? [];

      // Debug prints
      print('servicesData: $servicesData');
      print('servicesData type: ${servicesData.runtimeType}');

      List<ServiceCreatingModel> services = servicesData.map((service) {
        print('service: $service');
        print('service type: ${service.runtimeType}');
        return ServiceCreatingModel.fromMap(service as Map<String, dynamic>);
      }).toList();

      return services;
    } catch (e) {
      print('=========Error fetching services: $e');
      return [];
    }
  }
}


