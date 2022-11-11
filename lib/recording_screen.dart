import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spin_360/video_saving.dart';

class Recording extends StatefulWidget {
  const Recording({Key? key}) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  bool isPlay = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 70.w, right: 69.w, top: 20.h),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                    TextSpan(
                        text: 'Hero9 Black ',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                decoration: TextDecoration.none))),
                    TextSpan(
                        text: 'is Connected',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                decoration: TextDecoration.none)))
                  ])),
              SizedBox(
                height: 86.h,
              ),
              SizedBox(
                height: 58.h,
              ),
              Text("Tap to start recording",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color.fromRGBO(0, 0, 0, 0.51)))),
              SizedBox(
                height: 37.h,
              ),
              Container(
                height: 152.h,
                width: 152.w,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(191, 196, 207, 0.58),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlay = !isPlay;
                      print('Lotus${isPlay}');
                    });
                  },
                  child: AnimatedContainer(
                      curve: Curves.slowMiddle,
                      duration: Duration(seconds: 1),
                      height: 76.h,
                      width: 76.w,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(236, 16, 82, 1),
                          shape:
                              (isPlay) ? BoxShape.circle : BoxShape.rectangle)),
                ),
              ),
              SizedBox(
                height: 97.h,
              ),
              GestureDetector(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoSaving()));
                },
                child: Text("Disconnect device",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            color: Color.fromRGBO(84, 146, 255, 1)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
