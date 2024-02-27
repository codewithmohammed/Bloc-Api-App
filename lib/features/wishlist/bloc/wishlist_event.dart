part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

final class RemoveFromWishlistEvent extends WishlistEvent {
  final int id;
  RemoveFromWishlistEvent({required this.id});
}

final class WishlistInitialEvent extends WishlistEvent{}

final class OnWishlistGoBackButtonClicked extends WishlistEvent{}