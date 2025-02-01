import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required String nameOfScreen});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        // backgroundColor: Colors.blueAccent,
      ),
      body: Center(child: notify()
          // const Column(
          //   //mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Spacer(),
          //     Center(
          //       child: Icon(
          //         Icons.notifications_rounded,
          //         size: 150,
          //       ),
          //     ),
          //     Text(
          //       'No Notification to show',
          //       style: TextStyle(
          //           color: Colors.blueAccent,
          //           fontSize: 25,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Center(
          //       child: Text(
          //         'You currently have a no notification we will \n  notify you when something new happens!',
          //         style: TextStyle(fontSize: 18),
          //       ),
          //     ),
          //     Spacer(),
          //   ],
          // ),
          ),
    );
  }

  Widget notify() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Center(
            child: Image.asset(
          'assets/images/remove.png',
          height: MediaQuery.of(context).size.height * 0.2,
        )),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'No Notification to show',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            'You currently have a no notification we will \n  notify you when something new happens!',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
        )
      ],
    );
  }
}
