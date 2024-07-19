import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/appbar/blur_appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/service/service_booking_controller.dart';

class YHMServiceBookManualLocation extends StatelessWidget {
  YHMServiceBookManualLocation({
    super.key,
    required this.mCity,
    required this.liveServiceDescription,
    required this.liveServiceCategory,
    required this.liveServiceInitialCost,
    required this.mArea,
    required this.mPostalCode,
    required this.mapAdministrativeArea,
    required this.mState,
    required this.mapCountry,
    required this.mapLat,
    required this.mapLng,
    required this.mapLocality,
    required this.mapPostalCode,
    required this.mapStreet,
    required this.serviceID,
    required this.serviceProviderEmail,
    required this.serviceProviderID,
    required this.serviceProviderName,
    required this.serviceProviderNumber,
    required this.liveServiceID,
    required this.liveServiceStatus,
    required this.estimatedCost,
    required this.kms,
    required this.rating,
    required this.liveServiceImg,
  });

  final String mCity;
  final String liveServiceDescription;
  final String liveServiceCategory;
  final String liveServiceInitialCost;
  final String mArea;
  final String mPostalCode;
  final String mapAdministrativeArea;
  final String mState;
  final String mapCountry;
  final String mapLat;
  final String mapLng;
  final String mapLocality;
  final String mapPostalCode;
  final String mapStreet;
  final String serviceID;
  final String serviceProviderEmail;
  final String serviceProviderID;
  final String serviceProviderName;
  final String serviceProviderNumber;
  final String liveServiceID;
  final String liveServiceStatus;
  final String estimatedCost;
  final String kms;
  final String rating;
  final String liveServiceImg;

  final ServiceBookingController serviceBookingController =
  Get.find<ServiceBookingController>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != serviceBookingController.selectedDate.value)
      serviceBookingController.selectedDate.value = picked;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != serviceBookingController.selectedTime.value)
      serviceBookingController.selectedTime.value = picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YHMBlurAppBar(
        title: 'Book your slot',
        showBackArrow: true,
        leadPadding: 30,
        leadingIcon: Icons.abc,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 00),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 260,
                  width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: serviceBookingController.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: serviceBookingController.desLocation!,
                      zoom: 19.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(''),
                        position: LatLng(serviceBookingController.mapLat.value,
                            serviceBookingController.mapLng.value),
                      )
                    },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: YHMColors.white, width: 1),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: YHMColors.white, width: 1),
                      color: YHMColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.info_circle),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'We collect your location information so that the doctor can provide you with an appointment that is convenient and relevant to your area.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: serviceBookingController.manualLocationFrom,
                    child: Column(
                      children: [
                        /// house Num
                        TextFormField(
                          controller: serviceBookingController.userHouseNum,
                          validator: (value) => YHMValidator.validateEmptyText(
                              'House or Shop Num ', value),
                          decoration: InputDecoration(
                            labelText: "House / Shop Num & Area",
                            hintText: 'e.g. 25, Tilak Nagar Society',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            prefixIcon: Icon(Iconsax.home_2),
                          ),
                          expands: false,
                        ),
                        const SizedBox(height: YHMSizes.spaceBtwInputFields),

                        /// Area
                        TextFormField(
                          controller: serviceBookingController.userArea,
                          validator: (value) =>
                              YHMValidator.validateEmptyText('Area', value),
                          decoration: InputDecoration(
                            labelText: "Area",
                            hintText: 'e.g. Mahavir Circle',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            prefixIcon: Icon(Iconsax.location),
                          ),
                          expands: false,
                        ),
                        const SizedBox(height: YHMSizes.spaceBtwInputFields),

                        /// Date
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller:
                              serviceBookingController.dateController,
                              validator: (value) =>
                                  YHMValidator.validateEmptyText('Date', value),
                              decoration: InputDecoration(
                                labelText: "Select Date",
                                hintText: 'Tap here to select date',
                                hintStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(Iconsax.calendar),
                              ),
                              expands: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: YHMSizes.spaceBtwInputFields),

                        /// Time
                        GestureDetector(
                          onTap: () => _selectTime(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller:
                              serviceBookingController.timeController,
                              validator: (value) =>
                                  YHMValidator.validateEmptyText(
                                      'Time Slot', value),
                              decoration: InputDecoration(
                                labelText: "Book Time Slot",
                                hintText: 'Tap here to Book Time Slot',
                                hintStyle: Theme.of(context).textTheme.bodySmall,
                                prefixIcon: Icon(Iconsax.timer_1),
                              ),
                              expands: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: YHMSizes.spaceBtwInputFields),

                        /// Instruction
                        TextFormField(
                          controller: serviceBookingController.userIntrucation,
                          validator: (value) => YHMValidator.validateEmptyText(
                              'Instruction', value),
                          decoration: InputDecoration(
                            hintMaxLines: 5,
                            labelText: "Instruction",
                            hintText:
                            'e.g. • Just opposite side of bapod lake\n       • Ring the bell on the door\n       • Urgent Need',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            prefixIcon: Icon(Iconsax.note),
                          ),
                          expands: false,
                        ),
                        const SizedBox(height: YHMSizes.spaceBtwInputFields),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        serviceBookingController.bookService(
                          serviceProviderID,
                          serviceProviderEmail,
                          liveServiceID,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text('Book Now'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
