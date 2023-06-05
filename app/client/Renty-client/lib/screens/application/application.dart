// import 'package:client/bloc/application/application_bloc.dart';
// import 'package:client/bloc/application/application_event.dart';
// import 'package:client/bloc/application/application_state.dart';
// import 'package:client/screens/application/widgets/application_widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Application extends StatefulWidget {
//   const Application({super.key});

//   @override
//   State<Application> createState() => _ApplicationState();
// }

// class _ApplicationState extends State<Application> {
  

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ApplicationBloc, ApplicationState>(
//       builder: (context, state) {
//         return Container(
//           color: Colors.white,
//           child: SafeArea(
//             child: Scaffold(
//               body: buildScreen(state.index),
//               bottomNavigationBar: BottomNavigationBar(
//                 elevation: 0,
//                 type: BottomNavigationBarType.fixed,
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 selectedItemColor: Colors.black,
//                 unselectedItemColor: Colors.grey,
//                 currentIndex: state.index,
//                 onTap: (value) {
//                   setState(() {
//                     context.read<ApplicationBloc>().add(TriggerAppEvent(value));
//                   });
//                 },
//                 items: bottomTabs,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
