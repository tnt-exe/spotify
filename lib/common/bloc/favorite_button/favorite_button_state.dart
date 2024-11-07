abstract class FavoriteButtonState {}

class FavoriteButtonInit extends FavoriteButtonState {}

class FavoriteButtonUpdate extends FavoriteButtonState {
  final bool isFavorite;

  FavoriteButtonUpdate({
    required this.isFavorite,
  });
}
