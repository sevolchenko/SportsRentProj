import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool autoLeading;

  const MyAppBar({Key? key, required this.title, this.autoLeading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 30.w,
      automaticallyImplyLeading: autoLeading,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Container(
            // alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              title,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Divider(
            height: 15,
            indent: 35,
            endIndent: 35,
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
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
