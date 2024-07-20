import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/features/personalization/controller/user_controller.dart';

class YourAppointmentsController extends GetxController {
  final isLoading = false.obs;
  final userController = Get.find<UserController>();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // RxList to hold fetched appointments
  var appointments = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  void fetchAppointments() {
    // Query Firestore for appointments where userId matches the current user's ID
    _firestore
        .collection('bookService')
        .where('userId', isEqualTo: userController.user.value.id)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      appointments.value = querySnapshot.docs;
    });
  }
}
