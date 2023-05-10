import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          color: Colors.black.withOpacity(0.8),
          height: 1.5,
        ),
      ),
      // backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15.h),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
    return appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
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
