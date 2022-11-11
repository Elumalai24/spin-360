// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// class Checking extends StatefulWidget {
//   const Checking({Key? key}) : super(key: key);
//
//   @override
//   State<Checking> createState() => _CheckingState();
// }
//
// class _CheckingState extends State<Checking> {
//   final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
//   final List<BluetoothDevice> _devicesList = [];
//   Future initBleList() async {
//     await Permission.bluetooth.request();
//     await Permission.bluetoothConnect.request();
//     await Permission.bluetoothScan.request();
//     await Permission.bluetoothAdvertise.request();
//     flutterBlue.connectedDevices.asStream().listen((devices) {
//       for (var device in devices) {
//         _addDeviceTolist(device);
//       }
//     });
//     flutterBlue.scanResults.listen((scanResults) {
//       for (var result in scanResults) {
//         _addDeviceTolist(result.device);
//       }
//     });
//     flutterBlue.startScan();
//   }
//   void _addDeviceTolist(BluetoothDevice device) {
//     if (!_devicesList.contains(device)) {
//       setState(() {
//         _devicesList.add(device);
//       });
//     }
//   }
//   @override
//   void initState() {
//     initBleList();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar:AppBar(title: Text('GoPro')),
//           body: Container(
//
//             child:Column(children: [
//               _buildListViewOfDevices()
//             ],) ,
//           ),
//     );
//   }
//   ListView _buildListViewOfDevices() {
//     List<Widget> containers = [];
//     for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
//       containers.add(
//         SizedBox(
//           height: 60,
//           child: Row(
//             children: <Widget>[
//               Expanded(child: Column(children: <Widget>[Text(device.name), Text(device.id.toString())])),
//               ElevatedButton(
//                 child: const Text('Connect', style: TextStyle(color: Colors.white)),
//                 onPressed: () async {},
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return ListView(padding: const EdgeInsets.all(8), children: <Widget>[...containers]);
//   }
// }
