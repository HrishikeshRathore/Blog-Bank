import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connectivity_enum.dart';

class NetworkSensitive extends StatefulWidget {
  final Widget child1;
  final Widget child2;

  NetworkSensitive({this.child1, this.child2});

  @override
  _NetworkSensitiveState createState() => _NetworkSensitiveState();
}

class _NetworkSensitiveState extends State<NetworkSensitive> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if(connectionStatus == ConnectivityStatus.WiFi || connectionStatus == ConnectivityStatus.Cellular) {
      return widget.child1;
    }
    return widget.child2;
  }

}