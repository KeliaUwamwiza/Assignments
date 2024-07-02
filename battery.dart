import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

class BatteryLevelDemo extends StatefulWidget {
  const BatteryLevelDemo({Key? key}) : super(key: key);

  @override
  _BatteryLevelDemoState createState() => _BatteryLevelDemoState();
}

class _BatteryLevelDemoState extends State<BatteryLevelDemo> {
  final Battery _battery = Battery();
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      _checkBatteryLevel(state);
    });
  }

  void _checkBatteryLevel(BatteryState state) {
    if (state == BatteryState.full) {
      showSnackBar('Battery fully charged!');
    } else if (state == BatteryState.charging) {
      showSnackBar('Battery is charging...');
    } else if (state == BatteryState.discharging) {
      _battery.batteryLevel.then((level) {
        if (level == 99) {
          showSnackBar('Battery level at 99%');
        } else if (level == 20) {
          showSnackBar('Battery level at 20%');
        }
      });
    }
  }

  @override
  void dispose() {
    _batteryStateSubscription.cancel();
    super.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Detecting battery state changes...'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _battery.batteryLevel.then((level) {
                showSnackBar('Current Battery Level: $level%');
              });
            },
            child: Text('Check Battery Level'),
          ),
        ],
      ),
    );
  }
}
