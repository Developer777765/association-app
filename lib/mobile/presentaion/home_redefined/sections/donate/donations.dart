import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Donation extends StatelessWidget {
  String? event;
  String? subtitleOfEvent;
  String? descriptionOfEvent;
  String? image;
  String? price;
  Donation(
      {super.key,
      required this.event,
      required this.subtitleOfEvent,
      required this.descriptionOfEvent,
      required this.image});
  @override
  build(context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                image!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ],
        ),
        Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5), // Adjust overlay opacity here
            // borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(event!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18)),
                  const Spacer(),
                  const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  )
                ],
              ),
              Text(
                subtitleOfEvent!,
                style: const TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              Text(
                descriptionOfEvent!,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(children: [
                const Spacer(),
                ElevatedButton(onPressed: () {}, child: const Text('Donate'))
              ]),
            ],
          ),
        )
      ],
    );
  }
}
