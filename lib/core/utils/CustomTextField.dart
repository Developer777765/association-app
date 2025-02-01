// ignore_for_file: use_super_parameters, library_private_types_in_public_api, must_be_immutable, use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/data/repository/login_repository.dart';

final userDataProvider = StateProvider<Map>((ref) {
  return {};
});

final citiesProvider = StateProvider<List>((ref) {
  return [];
});

final cityProvider = StateProvider<String>((ref) {
  return 'Town/City, Block, District,';
});

final countryProvider = StateProvider<String>((ref) {
  return 'Country';
});

final nameOfStateProvider = StateProvider<String>((ref) {
  return 'State';
});

class CustomTextField extends ConsumerStatefulWidget {
  String? label;
  String? hint;
  double? customWidth;
  double? customHeight;
  TextInputType? keyBoardType;
  Widget? iconOfField;
  bool? isFieldNotEditable;
  TextEditingController? controller;
  String? initialText;
  final List<TextInputFormatter>? inputFormatters; // New property

  CustomTextField({
    this.label,
    this.hint,
    this.keyBoardType,
    this.customWidth,
    this.customHeight,
    this.iconOfField,
    this.isFieldNotEditable,
    this.controller,
    this.initialText,
    this.inputFormatters,
  });

  @override
  ConsumerState<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends ConsumerState<CustomTextField> {
  bool isDOBpicked = false;
  String pickDateOfBirth = '';
  DateTime? pickedDate;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    ////////////////Disabled for now////////////////
    // controller = TextEditingController();
    ////////////////Disabled for now////////////////
    // Use the passed controller, or create a new one if it's null
    controller = widget.controller ?? TextEditingController();

    // If widget.controller was provided, don't overwrite it with a new instance
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      controller.text = widget.controller!.text;
    }
  }

  @override
  void dispose() {
    // Dispose controller to avoid memory leaks
    controller.dispose();
    super.dispose();
  }

  @override
  build(context) {
    return SizedBox(
      height: widget.customHeight,
      width: widget.customWidth ?? MediaQuery.of(context).size.width - 30,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
            onChanged: (val) async {
              if (widget.label == 'PinCode') {
                if (val.length == 6) {
                  var result =
                      await LoginRepository().getPostalCodeDetails(val);

                  List postOffices = result['PostOffice'];
                  var cities = List.generate(postOffices.length, (index) {
                    return '${postOffices[index]['Name']}, ${postOffices[index]['Taluk']}, ${postOffices[index]['District']}';
                  }, growable: true);
                  ref.read(citiesProvider.notifier).state = cities;
                  var state = result['PostOffice'][0]['State'];
                  var country = result['PostOffice'][0]['Country'];
                  ref.read(nameOfStateProvider.notifier).state = state;
                  ref.read(countryProvider.notifier).state = country;
                }
              }
            },
            onTap: () async {
              if (widget.isFieldNotEditable!) {
                pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    isDOBpicked = true;
                    controller.text = pickedDate.toString().substring(0, 10);
                    pickDateOfBirth = pickedDate.toString().substring(0, 10);
                  });
                }
              }
            },
            readOnly: widget.isFieldNotEditable!,
            validator: (val) {
              var currentData = ref.read(userDataProvider.notifier).state;
              bool isEmailValid = false;
              // bool isValidYear = false;
              if (val!.isEmpty) {
                return widget.label == 'Parent\'s Phone No(Optional)' ||
                        widget.label == 'Wife\'s Phone No(Optional)'
                    ? null
                    : 'please enter your ${widget.label}';
              } else {
                if (widget.label == 'Email') {
                  final emailRegex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  isEmailValid = emailRegex.hasMatch(val);
                  isEmailValid
                      ? ref.read(userDataProvider.notifier).state = {
                          ...currentData,
                          widget.label: val
                        }
                      : {widget.label: ''};
                  return isEmailValid ? null : 'enter a valid Email';
                } else if (widget.label == 'Phone No') {
                  if (val.length == 10) {
                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: val
                    };
                  }
                  return val.length == 10
                      ? null
                      : 'enter a valid mobile number';
                } else if (widget.label == 'Parent\'s Phone No') {
                  if (val.length == 10) {
                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: val
                    };
                  }
                  return val.length == 10
                      ? null
                      : 'enter a valid mobile number';
                } else if (widget.label == 'Wife\'s Phone No') {
                  if (val.length == 10) {
                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: val
                    };
                  }
                  return val.length == 10
                      ? null
                      : 'enter a valid mobile number';
                } else if (widget.label == 'Date of Birth') {
                  final dateFormat = DateFormat('yyyy-MM-dd');
                  final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  String? dob;
                  if (isDOBpicked) {
                    dob = pickDateOfBirth;
                  } else {
                    dob = val;
                  }

                  //TODO: for edit profile

                  //TODO: for edit profile

                  /////////////disabled for now/////////////
                  // String dob = pickDateOfBirth;
                  /////////////disabled for now/////////////

                  if (regex.hasMatch(dob!)) {
                    // return null; // Invalid format
                  }
                  try {
                    // Parse the date
                    final parsedDate = dateFormat.parseStrict(dob);

                    // Ensure date is not in the future
                    if (parsedDate.isAfter(DateTime.now())) {
                      return 'Enter valid ${widget.label}';
                    }

                    // Ensure date is a reasonable past date
                    if (parsedDate.isBefore(DateTime(1900))) {
                      return 'Enter valid ${widget.label}';
                    }

                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: parsedDate.toString()
                    };

                    return null; // Valid date
                  } catch (e) {
                    debugPrint('the exception is $e');
                    return 'Enter a valid ${widget.label}'; // Parsing failed
                  }
                } else if (widget.label == 'PinCode') {
                  if (val.length == 6) {
                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: val
                    };
                    return null;
                  } else {
                    return 'Enter a valid ${widget.label}';
                  }
                } else if (widget.label == 'House no.,Street name,') {
                  if (val.length > 5) {
                    ref.read(userDataProvider.notifier).state = {
                      ...currentData,
                      widget.label: val
                    };
                    return null;
                  } else {
                    return 'Enter a valid address';
                  }
                } else {
                  ref.read(userDataProvider.notifier).state = {
                    ...currentData,
                    widget.label: val
                  };
                }
              }

              // ref.read(userDataProvider.notifier).state = {widget.label: val};

              return null;
            },
            controller: controller,
            keyboardType: widget.keyBoardType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
                prefixIcon: widget.iconOfField,
                border: InputBorder.none,
                labelText: widget.label,
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 8))),
      ),
    );
  }
}

class CommomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onTap;
  double? customWidth;
  final bool readOnly;
  double? customHeight;
  final List<TextInputFormatter>? inputFormatters;

  CommomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onTap,
    this.readOnly = false,
    this.customHeight,
    this.customWidth,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 55,
        width: customWidth,
        padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          autovalidateMode: autovalidateMode,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
          ),
          validator: validator,
          onTap: onTap,
        ),
      ),
    );
  }
}
