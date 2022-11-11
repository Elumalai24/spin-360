import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'camera_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller=TextEditingController();
  TextEditingController _pasController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
        padding: EdgeInsets.only(left:16.w,right: 16.w,top: 144.h,bottom: 20.h ),
        child:
        Column(
children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("LOGO",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
            fontSize:48.33.sp,color:Color.fromRGBO(84, 146, 255, 1)))),

    ],
  ),
  SizedBox(height: 104.h,),
  TextFormField(

   // autovalidateMode: AutovalidateMode.onUserInteraction,
 //   keyboardType:TextInputType.number ,


    style: TextStyle(
        fontSize:13.sp, fontWeight: FontWeight.w500),
    cursorColor: Colors.black,
    controller: _controller,

    decoration: InputDecoration(
      // border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 10),

      labelText: 'ID Number',
      labelStyle: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.52))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
          // borderRadius: BorderRadius.circular(5.w)
          borderRadius: BorderRadius.circular(4)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
          //  borderRadius: BorderRadius.circular(5.w)
          borderRadius: BorderRadius.circular(4)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
    ),
  ),
  SizedBox(height: 13.h,),
  TextFormField(

    // autovalidateMode: AutovalidateMode.onUserInteraction,
    //   keyboardType:TextInputType.number ,


    style: TextStyle(
        fontSize:13.sp, fontWeight: FontWeight.w500),
    cursorColor: Colors.black,
    controller: _pasController,

    decoration: InputDecoration(
      // border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 10),

      labelText: 'Password',
      labelStyle: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.52))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
          // borderRadius: BorderRadius.circular(5.w)
          borderRadius: BorderRadius.circular(4)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
          //  borderRadius: BorderRadius.circular(5.w)
          borderRadius: BorderRadius.circular(4)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1.w),
      ),
    ),
  ),
  SizedBox(height: 25.h,),
  Text("Scan QR code",style:GoogleFonts.inter( decoration: TextDecoration.underline,
      textStyle:TextStyle(fontWeight:FontWeight.w500,
      fontSize:18.sp,color:Color.fromRGBO(82, 127, 245, 1)))),
Spacer(),
ElevatedButton(

    style: ElevatedButton.styleFrom(
primary: Color.fromRGBO(15, 32, 81, 1),
        elevation: 0,
        minimumSize: Size(274.w, 50.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
        

    ),onPressed: (){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraDevices()));

}, child:Text("Let’s Spin",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
    fontSize:20.sp,color:Color.fromRGBO(255, 255, 255, 1)))),
),

],
        ),
      ),),
    );
  }
}
