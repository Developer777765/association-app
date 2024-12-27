import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen extends ConsumerStatefulWidget {
  @override
  createState() => TestScreenState();
}

class TestScreenState extends ConsumerState<TestScreen> {
  @override
  build(context) {
    return Scaffold(
      body: const Center(
        child: Text('Nothing'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8.0),
        color: Colors.amber,
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                  height: double.infinity - 50,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.home,
                        ),
                      ),
                      const Text('Home')
                    ],
                  )),
            ),
            Expanded(
              child: SizedBox(
                  height: double.infinity - 50,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.home,
                        ),
                      ),
                      const Text('Home')
                    ],
                  )),
            ),
            Expanded(
              child: SizedBox(
                  height: double.infinity - 50,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.home,
                        ),
                      ),
                      const Text('Home')
                    ],
                  )),
            ),
            Expanded(
              child: SizedBox(
                  height: double.infinity - 50,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.home,
                        ),
                      ),
                      const Text('Home')
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
