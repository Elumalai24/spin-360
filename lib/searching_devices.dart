import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spin_360/recording_screen.dart';


class SerchingDevices extends StatefulWidget {
  const SerchingDevices({Key? key}) : super(key: key);

  @override
  State<SerchingDevices> createState() => _SerchingDevicesState();
}

class _SerchingDevicesState extends State<SerchingDevices> {
  List<ControlButton> controlButtons = [];
  List<BluetoothService>? bluetoothServices;
  final List<BluetoothDevice> _devicesList = [];
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  String? readableValue;
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
  void _addDeviceTolist(BluetoothDevice device) {
    if (!_devicesList.contains(device)) {
      setState(
              () {
            _devicesList.add(device);
          });
    }
  }
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(

            padding: EdgeInsets.only(top: 20.h ),
            child: Column(children: [
          Padding(
            padding:  EdgeInsets.only(left: 16.w,right: 16.w),
            child: Row(

              children: [

                Text("Searching for devices",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w500,
                    fontSize:20.sp,color:Color.fromRGBO(0,0,0, 1)))),
Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close,color: Color.fromRGBO(0,0,0,1),
                    size: 28.sp,
                  ),
                ),


              ],
            ),
          ),
          SizedBox(height: 78.h,),
          Text("Tap the device name to connect",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
              fontSize:16.sp,color:Color.fromRGBO(0,0,0, 51)))),
          SizedBox(height: 40.h,),

       // Expanded(child: _buildListViewOfDevices()),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemBuilder: ( context,index)  {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Recording()));

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        padding: EdgeInsets.all(13.w),
                        height: 58.h,width: 58.w,
                        decoration: BoxDecoration(shape: BoxShape.circle,

                            border: Border.all(width: 1,color: Color.fromRGBO(82, 127, 245, 1),)
                        ),
                        child: SvgPicture.asset(
                          'assets/go_pro_img.svg',
                          height: 20.h,
                          width: 29.w,),
                      ),
                    ),
                    SizedBox(height: 13.h,),
                    Text("Hero9 Black",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                        fontSize:18.sp,color:Color.fromRGBO(0,0,0, 1)))),
                  ],
                );
              },
            ),
          ),


         // SizedBox(height: 246.h,),
              Divider(thickness: 0.1,color: Colors.black),
          Container(

            width:double.infinity,
            height: 60.h,
            child: Center(
              child: Text("Refresh",style:GoogleFonts.inter( decoration: TextDecoration.underline,
                  textStyle:TextStyle(fontWeight:FontWeight.w500,
                      fontSize:18.sp,color:Color.fromRGBO(82, 127, 245, 1)))),
            ),
          ),
        ],)),
      ),
    );
  }

  GridView _buildListViewOfDevices() {
    List<Widget> containers = [];
    for (BluetoothDevice device in _devicesList.where((element) => element.name.isNotEmpty)) {
      containers.add(
        Container(
         // color: Colors.green.shade100,
          height: 60,
          child: Column(
mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              // ElevatedButton(
              //   child: const Text('Connect', style: TextStyle(color: Colors.white)),
              //   onPressed: () async {
              //     if (device.name.contains('GoPro')) {
              //       try {
              //         await device.connect();
              //         controlButtons.addAll([
              //           ControlButton(buttonName: 'Record On', onTap: () => writeValue([0x03, 0x01, 0x01, 0x01])),
              //           ControlButton(buttonName: 'Record Off', onTap: () => writeValue([0x03, 0x01, 0x01, 0x00])),
              //           ControlButton(buttonName: 'Camera sleep', onTap: () => writeValue([0x01, 0x05])),
              //           ControlButton(buttonName: 'Show camera WiFi AP SSID', onTap: () => readValue('0002')),
              //           ControlButton(buttonName: 'Show camera WiFi AP Password	', onTap: () => readValue('0003')),
              //         ]);
              //         List<BluetoothService> services = await device.discoverServices();
              //         setState(() {
              //           bluetoothServices = services;
              //         });
              //       } catch (e) {
              //         await device.disconnect();
              //       }
              //     }
              //   },
              // ),
              Flexible(
                child: GestureDetector(
                  onTap: () async {
                    if (device.name.contains('GoPro')) {
                      try {
                        await device.connect();
                        controlButtons.addAll([
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
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    padding: EdgeInsets.all(13.w),
                    height: 58.h,width: 58.w,
                    decoration: BoxDecoration(shape: BoxShape.circle,

                        border: Border.all(width: 1,color: Color.fromRGBO(82, 127, 245, 1),)
                    ),
                    child: SvgPicture.asset(
                      'assets/go_pro_img.svg',
                      height: 20.h,
                      width: 29.w,),
                  ),
                ),
              ),
              SizedBox(height: 13.h,),
              Text(device.name),
            ],
          ),
        ),
      );
    }
    return GridView(padding: const EdgeInsets.all(8),    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
    ),
        children: <Widget>[...containers]);
  }
}
class ControlButton {
  final String buttonName;
  final Function() onTap;

  ControlButton({required this.buttonName, required this.onTap});
}