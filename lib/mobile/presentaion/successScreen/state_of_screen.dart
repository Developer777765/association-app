import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class StateOfScreen extends ConsumerStatefulWidget {
  const StateOfScreen({super.key});

  @override
  createState() => StateOfScreenState();
}

class StateOfScreenState extends ConsumerState<StateOfScreen>
    with TickerProviderStateMixin {
  late final AnimationController partyPopperController;
  late final AnimationController ariseController;
  late final AnimationController fadeInController;
  late final AnimationController fadeInAndAriseController;

  late final Animation<Color?> fade;
  late final Animation<double> arise;

  @override
  void initState() {
    super.initState();
    partyPopperController = AnimationController(vsync: this);
    fadeInAndAriseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    ariseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    fade = ColorTween(begin: Colors.white, end: Color(0xFFFFE4B5)).animate(
        CurvedAnimation(
            parent: fadeInAndAriseController, curve: Curves.easeIn));
    arise = Tween<double>(begin: 15.0, end: 0.0).animate(CurvedAnimation(
        parent: fadeInAndAriseController, curve: Curves.easeIn));

    fadeInAndAriseController.forward();
  }

  @override
  void dispose() {
    partyPopperController.dispose();
    ariseController.dispose();
    // fadeInController.dispose();
    super.dispose();
  }

  @override
  build(context) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Center(
            child: Lottie.asset('assets/animations/successAnimation.json',
                controller: partyPopperController, onLoaded: (composition) {
              // Set the duration to the animation's duration
              partyPopperController
                ..duration = composition.duration
                ..forward(); // Play animation once

              // Pause the animation when it completes
              partyPopperController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  partyPopperController.stop();
                }
              });
            }),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.21,
                    width: MediaQuery.of(context).size.height * 0.21,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryFixedDim),
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.height * 0.14,
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Your Profile Has Been Created Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Note: You can not log in until the administrator approves your profile',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimatedBuilder(
                    animation: fadeInAndAriseController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, arise.value),
                        child: GestureDetector(
                          onTap: () {
                            // print('say hi');
                            Navigator.popAndPushNamed(context, 'LogIn');
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius:
                                        2, // How much the shadow spreads
                                    blurRadius: 5, // Softness of the shadow
                                    offset: const Offset(0,
                                        3), // Offset: x(horizontal), y(vertical)
                                  ),
                                ],
                                // color: fade.value,
                                color: fade.value,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width - 120,
                            child: const Center(
                              child: Text(
                                'Continue to Login',
                                style: TextStyle(
                                    color: Color(4283580209),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ),
          Center(
            child: Lottie.asset('assets/animations/successAnimation.json',
                controller: partyPopperController, onLoaded: (composition) {
              // Set the duration to the animation's duration
              partyPopperController
                ..duration = composition.duration
                ..forward(); // Play animation once

              // Pause the animation when it completes
              partyPopperController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  partyPopperController.stop();
                  // Navigator.pop(context);
                }
              });
            }),
          ),
        ]),
      ),
    );
  }
}
