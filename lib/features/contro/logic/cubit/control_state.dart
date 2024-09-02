part of 'control_cubit.dart';

@immutable
sealed class ControlState {}

final class ControlInitial extends ControlState {}

final class navigatestate extends ControlState {
    final int navigate;
  navigatestate({required this.navigate});
}

// final class screenstate extends ControlState {
//     final int navigate;
//   navigatestate({required this.navigate});
// }
