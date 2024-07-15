import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/personalization/screens/setting/widgets/register_pro_section.dart';
import 'package:your_health_mate/features/personalization/screens/setting/widgets/setting_menu_tile.dart';
import 'package:your_health_mate/features/personalization/screens/setting/widgets/user_profile_card.dart';
import '../../../../common/styles/spacing_style.dart';
import '../../../../common/widgets/Dividers/divider_line.dart';
import '../../../../common/widgets/headings/screen_sub_heading.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/sizes.dart';



class YHMSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: YHMBlurAppBar(title: 'Profile', showBackArrow: false,),
        body: SingleChildScrollView(
            child: Padding(
                padding: YHMSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// heading

                    // YHMScreenHeading(title: 'Profile'),
                    SizedBox(height: YHMSizes.appBarHeight+10,),

                    /// Profile Picture Section
                    UserProfileCard(),

                    const SizedBox(
                      height: YHMSizes.spaceBtwSections,
                    ),

                    /// Divider
                    // DividerLine(height: YHMSizes.spaceBtwItems,),



                    /// Register Professional
                    RegisterAsProSection(),



                    /// Settings
                    const SizedBox(height: YHMSizes.spaceBtwSections,),
                    ScreenSubHeading(title: 'Settings',),
                    SizedBox(height: YHMSizes.spaceBtwItems,),
                    SettingMenuTile(icon: Iconsax.profile_circle, title: 'Personal Information',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.routing, title: 'Your Addresses',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.language_circle, title: 'Languages',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.receipt_item, title: 'Services History',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.notification, title: 'Notifications',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.security_user, title: 'Login & Security',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),

                    /// Support
                    const SizedBox(height: YHMSizes.spaceBtwSections,),
                    ScreenSubHeading(title: 'Support',),
                    SizedBox(height: YHMSizes.spaceBtwItems,),
                    SettingMenuTile(icon: Iconsax.device_message, title: 'Visit the Help Centre',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.warning_2, title: 'Report',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.edit, title: 'Give us Feedback',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.emoji_happy, title: 'How Home-Helps Works ?',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),

                    /// Support
                    const SizedBox(height: YHMSizes.spaceBtwSections,),
                    ScreenSubHeading(title: 'Legal',),
                    SizedBox(height: YHMSizes.spaceBtwItems,),
                    SettingMenuTile(icon: Iconsax.book_1, title: 'Terms of Services',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),
                    SettingMenuTile(icon: Iconsax.book_1, title: 'Privacy Policy',trailing: Icon(Iconsax.arrow_right_3,size: 18,),),

                    SizedBox(height: YHMSizes.spaceBtwItems,),

                    /// Logout
                    InkWell(
                      onTap: (){AuthenticationRepository.instance.signOut();},
                      child: Text(
                        'Log out',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          decoration: TextDecoration.combine([
                            TextDecoration.underline,
                          ]),
                          decorationThickness: 0.6, // Adjust the thickness as needed
                        ),
                      ),
                    ),
                    SizedBox(height: YHMSizes.spaceBtwItems,),

                    /// Version of app
                    DividerLine(height: YHMSizes.spaceBtwSections),
                    SizedBox(height: YHMSizes.spaceBtwItems,),
                    Text('Version 1.0.0',style: Theme.of(context).textTheme.bodySmall,)





                  ],
                )
            )
        )
    );
  }
}









