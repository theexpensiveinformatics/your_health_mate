import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class YHMSignUpForm extends StatelessWidget {
  const YHMSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              /// first name
              Expanded(
                child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) {
                      return YHMValidator.validateEmptyText('First Name', value);
                    },
                    decoration: const InputDecoration(
                        labelText: YHMTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false),
              ),
              const SizedBox(
                width: YHMSizes.spaceBtwInputFields,
              ),

              /// last name
              Expanded(
                child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        YHMValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                        labelText: YHMTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false),
              ),
            ],
          ),

          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
              controller: controller.username,
              validator: (value) =>
                  YHMValidator.validateEmptyText('User Name', value),
              decoration: const InputDecoration(
                  labelText: YHMTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
              expands: false),

          const SizedBox(height: YHMSizes.spaceBtwInputFields),

          ///Email
          TextFormField(
              controller: controller.email,
              validator: (value) => YHMValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: YHMTexts.email, prefixIcon: Icon(Iconsax.direct)),
              expands: false),

          const SizedBox(height: YHMSizes.spaceBtwInputFields),

          ///Phone Number
          TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => YHMValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: YHMTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
              expands: false),

          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          ///Password
          Obx(
            () => TextFormField(
                obscureText: controller.hidePassword.value,
                validator: (value) => YHMValidator.validatePassword(value),
                controller: controller.password,
                decoration: InputDecoration(
                    labelText: YHMTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon:  Icon( controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
                expands: false),
          ),

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),

          /// Terms  & Conditions
          YHMTermsAndConditionCheckbox(),

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),


          ///Signup Button which will go to verify_email screen
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(YHMTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
