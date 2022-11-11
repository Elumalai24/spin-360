import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);
  @override
  State<PlayList> createState() => _PlayListState();
}
class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
        child: Column(
          children: [
            Text("Choose music",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 21.sp,
                        color: Color.fromRGBO(0, 0, 0, 1)))),
            Expanded(child: ListView.builder(itemBuilder: (context, _) {
              return ListTile(
                leading: CachedNetworkImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 400),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  imageUrl: 'assets/rough_img.svg',
                  errorWidget: (context, url, error) => Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/rough_img.svg"))),
                  ),
                ),
                title: Text("Choose music",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(0, 0, 0, 1)))),
              );
            }))
          ],
        ),
      ),
    ));
  }
}
