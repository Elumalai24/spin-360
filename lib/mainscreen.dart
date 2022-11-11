import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';


class GoPro extends StatelessWidget {
  const GoPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter BLE Demo',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final List<BluetoothDevice> _devicesList = [];
  List<BluetoothService>? bluetoothServices;
  List<ControlButton> controlButtons = [];
  String? readableValue;
  TextEditingController ssidControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();
  @override
  void initState() {
    initBleList();
    super.initState();
  }

  Future initBleList() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothAdvertise.request();
    flutterBlue.connectedDevices.asStream().listen((devices) {
      for (var device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((scanResults) {
      for (var result in scanResults) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan();
  }

  void _addDeviceTolist(BluetoothDevice device) {
    if (!_devicesList.contains(device)) {
      setState(
              () {
        _devicesList.add(device);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Flutter BLE')), body: bluetoothServices == null ? _buildListViewOfDevices() : Container(
padding: EdgeInsets.only(bottom: 200),

        child: Column(
          children: [
            Expanded(child: _buildControlButtons()),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: ssidControl,
                decoration: InputDecoration(labelText: 'SSID'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordControl,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
          ],
        )));
  }
  ListView _buildListViewOfDevices() {
    List<Widget> containers = [];
    for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
      containers.add(
        SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(child: Column(children: <Widget>[Text(device.name), Text(device.id.toString())])),
              ElevatedButton(
                child: const Text('Connect', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  print("Deena 14");
                  if (device.name.contains('GoPro')) {
                    try {
                      await device.connect();
                      controlButtons.addAll([
                        ControlButton(buttonName: "Ap control", onTap: () => writeValue([0x17]),),
                        ControlButton(buttonName: 'Record On', onTap: () => writeValue([0x03, 0x01, 0x01, 0x01])),
                        ControlButton(buttonName: 'Record Off', onTap: () => writeValue([0x03, 0x01, 0x01, 0x00])),
                        ControlButton(buttonName: 'Camera sleep', onTap: () => writeValue([0x01, 0x05])),
                        ControlButton(buttonName: 'Show camera WiFi AP SSID', onTap: () => readValue('0002')),
                        ControlButton(buttonName: 'Show camera WiFi AP Password	', onTap: () => readValue('0003')),
                      ]);
                      List<BluetoothService> services = await device.discoverServices();
                      setState(() {
                        bluetoothServices = services;
                      });
                    } catch (e) {
                      await device.disconnect();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[...containers]);
  }

  Widget _buildControlButtons() {
    return Column(
      children: [
        Wrap(
          children: controlButtons
              .map((e) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(onPressed: e.onTap, child: Text(e.buttonName)),
          ))
              .toList(),
        ),
        Center(child: Text(readableValue ?? '')),
      ],
    );
  }

  Future<void> writeValue(List<int> value) async {
    BluetoothService? bluetoothService = bluetoothServices?.firstWhere((element) => element.uuid.toString() == '0000fea6-0000-1000-8000-00805f9b34fb');
    BluetoothCharacteristic? bluetoothCharacteristic =
    bluetoothService?.characteristics.firstWhere((element) => element.uuid.toString() == 'b5f90072-aa8d-11e3-9046-0002a5d5c51b');
    bluetoothCharacteristic?.write(value);
  }

  Future<void> readValue(String characteristicUUID) async {
    BluetoothService? bluetoothService = bluetoothServices?.firstWhere((element) => element.uuid.toString() == 'b5f90001-aa8d-11e3-9046-0002a5d5c51b');

    BluetoothCharacteristic? bluetoothCharacteristic =
    bluetoothService?.characteristics.firstWhere((element) => element.uuid.toString() == 'b5f9$characteristicUUID-aa8d-11e3-9046-0002a5d5c51b');
    List<int>? utf8Response = await bluetoothCharacteristic?.read();
    setState(() {
      readableValue = utf8.decode(utf8Response ?? []);
    });
  }

}
class ControlButton {
  final String buttonName;
  final Function() onTap;

  ControlButton({required this.buttonName, required this.onTap});
}
enum WifiState { error, success, already }

class Wifi {
  static const MethodChannel _channel = const MethodChannel('plugins.ly.com/wifi');

  static Future<String> get ssid async {
    return await _channel.invokeMethod('ssid');
  }

  static Future<int> get level async {
    return await _channel.invokeMethod('level');
  }

  static Future<String> get ip async {
    return await _channel.invokeMethod('ip');
  }

  static Future<List<WifiResult>> list(String key) async {
    final Map<String, dynamic> params = {
      'key': key,
    };
    var results = await _channel.invokeMethod('list', params);
    List<WifiResult> resultList = [];
    for (int i = 0; i < results.length; i++) {
      resultList.add(WifiResult(results[i]['ssid'], results[i]['level']));
    }
    return resultList;
  }

  static Future<WifiState> connection(String ssid, String password) async {
    final Map<String, dynamic> params = {
      'ssid': ssid,
      'password': password,
    };
    int state = await _channel.invokeMethod('connection', params);
    switch (state) {
      case 0:
        return WifiState.error;
      case 1:
        return WifiState.success;
      case 2:
        return WifiState.already;
      default:
        return WifiState.error;
    }
  }
}

class WifiResult {
  String ssid;
  int level;

  WifiResult(this.ssid, this.level);
}