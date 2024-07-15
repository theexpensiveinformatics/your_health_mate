import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

class YHMLoginForm extends StatelessWidget {
  const YHMLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: YHMSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => YHMValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user), labelText: YHMTexts.email),
            ),
            const SizedBox(height: YHMSizes.spaceBtwInputFields),

            /// Password
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
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye))),
                  expands: false),
            ),

            const SizedBox(
              height: YHMSizes.spaceBtwInputFields / 2,
            ),

            /// Remember me & forget button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    Text(
                      YHMTexts.rememberMe,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),

                ///Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword(),
                        transition: Transition.fade),
                    child: const Text(YHMTexts.forgetPassword))
              ],
            ),
            const SizedBox(
              height: YHMSizes.spaceBtwSections,
            ),

            ///signin Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(YHMTexts.signIn),
              ),
            ),
            const SizedBox(
              height: YHMSizes.spaceBtwItems,
            ),

            ///Create Account
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen(),
                    transition: Transition.fade),
                child: const Text(YHMTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
