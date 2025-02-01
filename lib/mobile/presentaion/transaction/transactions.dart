import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back_ios_new),
          title: const Text(
            'Transaction',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'assets/images/empty.png',
              height: MediaQuery.of(context).size.height * 0.2,
            )),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'No transaction yet',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ),
            const Center(
              child: Text(
                '      After your first transaction,\n    you will be able to view it here.',
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ));
  }
}
