import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spin_360/play_list.dart';
class VideoSaving extends StatefulWidget {
  const VideoSaving({Key? key}) : super(key: key);

  @override
  State<VideoSaving> createState() => _VideoSavingState();
}

class _VideoSavingState extends State<VideoSaving> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left:38.w,right: 38.w,top: 20.h),
          child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(style:DefaultTextStyle.of(context).style,
                      children:[
                        TextSpan(text: 'Hero9 Black ',style: GoogleFonts.inter(textStyle: TextStyle(
                            fontWeight: FontWeight.w400,fontSize:18.sp,color: Color.fromRGBO(0, 0, 0, 1),decoration:
                        TextDecoration.none
                        ))),
                        TextSpan(text:'is Connected',style: GoogleFonts.inter(textStyle: TextStyle(
                            fontWeight: FontWeight.w400,fontSize:18.sp,color: Color.fromRGBO(0, 0, 0, 0.5),decoration:
                        TextDecoration.none
                        )))
                      ])
              ),
            ],
          ),
          SizedBox(height: 86.h,),
          SizedBox(height: 118.h,),
          SvgPicture.asset(
            'assets/video_rec.svg',
            height: 84.h,
            width: 129.w,),
            SizedBox(height: 31.h,),
            Text("Video Recorded",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w500,
                fontSize:22.sp,color:Color.fromRGBO(0, 0, 0, 1)))),
            SizedBox(height: 99.h,),
            Text("Retake",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                decoration: TextDecoration.underline,
                fontSize:20.sp,color:Color.fromRGBO(84, 146, 255, 1)))),
            SizedBox(height: 89.h,),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Color.fromRGBO(82, 127, 245, 1,),width: 1.w),
                  primary: Colors.white,
                  elevation: 0,
                  minimumSize: Size(283.w, 54.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))


              ),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>PlayList ()));
            }, child:Text("Add Music",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                fontSize:20.sp,color:Color.fromRGBO(82, 127, 245, 1)))),
            ),
            SizedBox(height: 20.h,),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(82, 127, 245, 1),
                  elevation: 0,
                  minimumSize: Size(283.w, 54.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))


              ),onPressed: (){}, child:Text("Save Video",style:GoogleFonts.inter(textStyle:TextStyle(fontWeight:FontWeight.w400,
                fontSize:20.sp,color:Color.fromRGBO(255, 255, 255, 1)))),
            ),
        ],),),
      ),
    );
  }
}
