import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? backFun;
  final bool leading;

  const MyAppBar(
      {Key? key, required this.title, this.backFun, this.leading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading
          ? backFun == null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: backFun,
                )
          : null,
      automaticallyImplyLeading: leading,
      title: Column(
        children: [
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: 10.h),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Divider(
            height: 20,
            indent: 35,
            endIndent: 35,
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
