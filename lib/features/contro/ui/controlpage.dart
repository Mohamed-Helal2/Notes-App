import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:note/features/contro/logic/cubit/control_cubit.dart';

class controlscreen extends StatelessWidget {
  const controlscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlCubit, ControlState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(8.h),
              padding: EdgeInsets.only(
                  bottom: 7.h, top: 7.h, right: 30.w, left: 30.w),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.h)),
              child: GNav(
                iconSize: 30,

                // backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                gap: 8.w,
                tabBackgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.all(15.h),
                onTabChange: (value) {
                  context.read<ControlCubit>().changeSelectedvalue(value);
                },
                tabs: const [
                  GButton(icon: Icons.home, text: "Home"),
                  GButton(icon: Icons.favorite, text: "Favourite"),
                ],
              ),
            ),
            body: context.read<ControlCubit>().currentscreen,
          ),
        );
      },
    );
  }
}
