// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, await_only_futures, unnecessary_brace_in_string_interps, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/data/dtos/get_all_companies_dto.dart';
import 'package:temple_app/data/repository/login_repository.dart';
import 'package:temple_app/services/customPainter.dart';
import '../../../utils/preference.dart';


final companyId = StateProvider<int>((ref) {
  return 0;
});

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initMethod();
  }

  Future<void> initMethod() async {
    await Future.delayed(Duration(seconds: 4), () async {
      //Hardcoded
      String customerName = 'Assocy';
      final userID = await Preference.shared.getString(Preference.USER_ID);
      debugPrint("preference ID is: $userID");
      GetAllCompaniesResponseDto response =
          await ref.read(getAllCompaniesProvider.future);
      for (var company in response.result!) {
        if (company.companyName == customerName) {
          ref.read(companyId.notifier).update((state) => company.uniqueId!);
          break;
        }
      }
      // debugPrint('companies as follow ${response.result![0].companyName}');
      if (userID == null) {
        Navigator.popAndPushNamed(context, 'LogIn');
        // Navigator.popAndPushNamed(context, 'BulkUpload');
      } else {
        //original code below(1 line only)
        Navigator.popAndPushNamed(context, 'HomeScreen');
        // Navigator.popAndPushNamed(context, 'BulkUpload');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.onSecondaryContainer
          // color: Theme.of(context).colorScheme.primaryContainer

          gradient: LinearGradient(colors: [
        // Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.primaryFixedDim,
        Theme.of(context).colorScheme.primaryContainer,
        // Theme.of(context).colorScheme.secondaryContainer,
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
      child: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CustomPainterOf(),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 5,
            top: MediaQuery.of(context).size.height / 5,
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: CustomPainterOf(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: [
                  // const Spacer(),
                  Image.asset(
                    'assets/images/unityMeansTogether.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.2,
                  ),
                  const Text(
                    'Assocy',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  // const Spacer(),
                ],
              ),
              Spacer(),
              Text('Version 1.0.0'),
              const SizedBox(
                height: 15,
              )
            ],
          )
        ],
      ),
    ));
  }
}
