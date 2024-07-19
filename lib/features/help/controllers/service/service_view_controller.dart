import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/Service/service_faq_model.dart';
import '../../models/Service/service_item.dart';

class ServiceViewController extends GetxController {
  static ServiceViewController get instance => Get.find();


  /// -- variables
  final isLoading = false.obs;
  final Rx<String> profilePicture = RxString('0');
  final List<NeedItemModel> needItems = <NeedItemModel>[].obs;
  final List<NeedItemModel> maintenanceTipsItems = <NeedItemModel>[].obs;
  final List<ServiceFaqModel> faqItems = <ServiceFaqModel>[].obs;

  Future<void> fetchNeedItems(String liveServiceName,String serviceProviderEmail) async {
    isLoading.value = true;
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshotUser = await users.where('Email', isEqualTo: serviceProviderEmail).get();

      print('======================$serviceProviderEmail');
      if (querySnapshotUser.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshotUser.docs.first;
        if((userDoc['ProfilePicture']).toString().isEmpty)
          {
            profilePicture.value='https://firebasestorage.googleapis.com/v0/b/home-helps.appspot.com/o/profilePicture.png?alt=media&token=ad690b0d-f465-4bd2-80a2-747792a23108';
          }else
            {
              profilePicture.value = userDoc['ProfilePicture'];
            }


      } else {

        profilePicture.value='https://firebasestorage.googleapis.com/v0/b/home-helps.appspot.com/o/profilePicture.png?alt=media&token=ad690b0d-f465-4bd2-80a2-747792a23108';

      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('serviceInformation')
          .doc(liveServiceName)
          .collection('needFromYou')
          .get();

      needItems.clear();

      QuerySnapshot querySnapshotManintence = await FirebaseFirestore.instance
          .collection('serviceInformation')
          .doc(liveServiceName)
          .collection('maintenanceTips')
          .get();
      maintenanceTipsItems.clear();

      QuerySnapshot querySnapshotFAQs = await FirebaseFirestore.instance
          .collection('serviceInformation')
          .doc(liveServiceName)
          .collection('faqs')
          .get();
      faqItems.clear();


      for (var doc in querySnapshot.docs) {
        needItems.add(NeedItemModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      for (var doc in querySnapshotManintence.docs) {
        maintenanceTipsItems.add(NeedItemModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      for (var doc in querySnapshotFAQs.docs) {
        faqItems.add(ServiceFaqModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      // print faqs
      faqItems.forEach((element) {
        print('FAQ: ${element.question}');
      });
    } catch (e) {
      print("Error fetching need items: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
