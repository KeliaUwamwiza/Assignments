import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet Connectivity Demo',
      home: InternetConnectivityDemo(),
    );
  }
}

class InternetConnectivityDemo extends StatefulWidget {
  const InternetConnectivityDemo({Key? key}) : super(key: key);

  @override
  _InternetConnectivityDemoState createState() => _InternetConnectivityDemoState();
}

class _InternetConnectivityDemoState extends State<InternetConnectivityDemo> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      // Handle connectivity changes here, e.g., show toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection status changed: $result')),
      );
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connectivity Demo'),
      ),
      body: const Center(
        child: Text('Detecting internet connectivity changes...'),
      ),
    );
  }
}
