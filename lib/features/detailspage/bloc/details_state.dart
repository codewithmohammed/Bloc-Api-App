part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {

}

final class GoBackToHomePage extends DetailsState{}

final class NavigateToUpdatePage extends DetailsState{}
final class NavigateToPatchPage extends DetailsState{}