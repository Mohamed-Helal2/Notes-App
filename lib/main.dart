import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/features/contro/logic/cubit/control_cubit.dart';
import 'package:note/features/contro/ui/controlpage.dart';
import 'package:note/features/folders/logic/folder_cubit/folders_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
        child: MultiBlocProvider(
      providers: [
        BlocProvider<FoldersCubit>(
            create: (context) => FoldersCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (context3) => ControlCubit(), child: const controlscreen()
            //FolderHome(),
            ),
      ),
    )
   );
  }
}
