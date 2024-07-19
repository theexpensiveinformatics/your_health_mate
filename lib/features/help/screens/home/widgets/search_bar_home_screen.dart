import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class SearchBarHomeScreen extends StatelessWidget {
  const SearchBarHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        // round corner

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        prefixIcon: Icon(Iconsax.search_normal_1),
        hintText: 'Search Services',
        suffixIcon: Icon(Iconsax.setting_4),
      ),
    );
  }
}