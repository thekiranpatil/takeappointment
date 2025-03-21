import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:flutter/material.dart';

class InputLabelWidget extends StatelessWidget {
  final String label;

  const InputLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Text(
        label,
        style: CustomTextStyles.inputLabel.copyWith(
          color: Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50,
        ),
      ),
    );
  }
}
