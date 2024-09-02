import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
 import 'package:note/features/favourite/ui/favouritepage.dart';
import 'package:note/features/folders/logic/folder_cubit/folders_cubit.dart';
import 'package:note/features/folders/ui/folder_home.dart';
 import 'package:note/features/home/logic/homecubit/home_cubit.dart';

part 'control_state.dart';

class ControlCubit extends Cubit<ControlState> {
  ControlCubit() : super(ControlInitial());
  int navigatorValue1 = 0;
  Widget currentscreen = FolderHome();
  void changeSelectedvalue(int selected_value) {
    navigatorValue1 = selected_value;
    switch (selected_value) {
      case 0:
        currentscreen = BlocProvider(
          create: (context) => FoldersCubit(),
          child: FolderHome(),
        );
        break;
      case 1:
        currentscreen = BlocProvider(
          create: (context) => HomeCubit(),
          child: const Favourtiepage(),
        );
        break;
      // case 2:
      //   currentscreen = calenderscreen();
      //   break;
    }
    emit(navigatestate(navigate: navigatorValue1));
  }
}
