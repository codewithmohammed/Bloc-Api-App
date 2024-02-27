class Validators {
  static String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  static String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    return null;
  }

  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  static String? categoryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a category';
    }
    return null;
  }

  static String? imageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image URL';
    }
    return null;
  }

  static String? ratingValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a rating';
    }
    return null;
  }
}
