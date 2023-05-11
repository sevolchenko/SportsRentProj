import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        leadingWidth: 30.w,
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                title,
                // textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Divider(
              height: 0,
              indent: 35,
              endIndent: 35,
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ));
    return appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}


// ******* OLD APP BAR *********
// class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   const MyAppBar({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: MediaQuery.of(context).size.height / 3 ,
//       padding: const EdgeInsets.only(top: 50),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Column(children: [
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Divider(color: Colors.black)
//             ]),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(130);
// }
