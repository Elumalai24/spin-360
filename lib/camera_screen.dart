import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spin_360/searching_devices.dart';

class CameraDevices extends StatefulWidget {
  const CameraDevices({Key? key}) : super(key: key);

  @override
  State<CameraDevices> createState() => _CameraDevicesState();
}

class _CameraDevicesState extends State<CameraDevices> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          padding: EdgeInsets.only(left:73.w,right: 73.w,top: 45.h ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Choose a Device",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w500,
                    fontSize:23.sp,color:Color.fromRGBO(0,0,0, 1)))),

              ],
            ),
            SizedBox(height: 43.h,),
            Container(
              padding: EdgeInsets.only(top: 43.h ),
              height: 214.h,width: 214.w,
              decoration: BoxDecoration(shape: BoxShape.circle,

border: Border.all(width: 1,color: Color.fromRGBO(0, 0, 0, 0.4),)
              ),
              child: Column(children: [

                SvgPicture.asset(
                  'assets/camera_img.svg',
                  height: 97.h,
                  width: 83.w,),
                SizedBox(height: 23.h),
                Text("Phone Camera",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                    fontSize:20.sp,color:Color.fromRGBO(82, 127, 245, 1)))),

              ],),
            ),
            SizedBox(height: 43.h,),
            Text("Or",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                fontSize:20.sp,color:Color.fromRGBO(0,0,0, 1)))),
            SizedBox(height: 43.h,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SerchingDevices()));
              },
              child: Container(
                padding: EdgeInsets.only(top: 43.h ),
                height: 214.h,width: 214.w,
                decoration: BoxDecoration(shape: BoxShape.circle,

                    border: Border.all(width: 1,color: Color.fromRGBO(0, 0, 0, 0.4),)
                ),
                child: Column(children: [

                  SvgPicture.asset(
                    'assets/go_pro_img.svg',
                    height: 97.h,
                    width: 83.w,),
                  SizedBox(height: 23.h),
                  Text("GoPro",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                      fontSize:20.sp,color:Color.fromRGBO(82, 127, 245, 1)))),

                ],),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
