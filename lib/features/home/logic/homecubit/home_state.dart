part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class Homereadsucess extends HomeState {
  final List readalldata;

  Homereadsucess({required this.readalldata});
  
}

final class Homereadidsucess extends HomeState {
  final List readiddata;

  Homereadidsucess({required this.readiddata});
  
}

final class favdatasucess extends HomeState {
 
   
}