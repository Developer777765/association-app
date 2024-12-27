import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedFloatingContainer extends ConsumerStatefulWidget {
  String? label;
  AnimatedFloatingContainer({this.label});
  @override
  ConsumerState<AnimatedFloatingContainer> createState() {
    return AnimatedFloatingContainerState();
  }
}

class AnimatedFloatingContainerState
    extends ConsumerState<AnimatedFloatingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> floatingAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    floatingAnimation = Tween(begin: 0.0, end: 15.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  build(context) {
    return AnimatedBuilder(
      animation: floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, floatingAnimation.value),
          child: child,
        );
      },
      child: Card(
        // color: Colors.purple,
        // width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.1,
        // decoration: BoxDecoration(boxShadow: const [
        //   BoxShadow(
        //       offset: Offset(0, 5),
        //       blurRadius: 10,
        //       spreadRadius: 2.0,
        //       color: Colors.grey)
        // ], borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(widget.label!),
        ),
      ),
    );
  }
}
