import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'custom_text_field.dart';

class CustomTextFormField extends FormField<String> {
  CustomTextFormField({
    super.key,
    required String title,
    required String hint,
    TextEditingController? controller,
    super.validator,
    super.onSaved,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String>? onChange,
    Widget? suffixIcon,
    double? width,
    double? height,
    int? maxLines = 1,
    Color? borderColor,
    bool readOnly = false,
    GestureTapCallback? onTap,
    bool obscureText = false,
  }) : super(
         autovalidateMode: autoValidateMode,
         builder: (FormFieldState<String> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomTextField(
                 title: title,
                 hint: hint,
                 controller: controller,
                 onChange: (val) {
                   state.didChange(val);
                   onChange?.call(val);
                 },
                 suffixIcon: suffixIcon,
                 width: width,
                 height: height,
                 maxLines: maxLines,
                 borderColor: borderColor,
                 readOnly: readOnly,
                 onTap: onTap,
                 obscureText: obscureText,
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(
                     top: AppDimens.paddingSmallest,
                   ),
                   child: Text(
                     state.errorText ?? '',
                     style: AppTextStyles.redS12Medium.copyWith(
                       fontStyle: FontStyle.italic,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
