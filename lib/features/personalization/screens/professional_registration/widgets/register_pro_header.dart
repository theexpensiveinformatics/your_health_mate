import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class RegisterAsAProHeader extends StatelessWidget {
  const RegisterAsAProHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          YHMTexts.becomePro,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: YHMSizes.sm,
        ),
        Text(
          YHMTexts.professionalTagline,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
