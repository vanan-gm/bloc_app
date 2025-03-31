extension StringExt on String{
  int toReadingTime(){
    final wordsCount = split(RegExp(r'\s+')).length;
    // Reading speed = distance / time
    // Average reading speed is between 200 and 300 so i get 250
    final readingTime = wordsCount / 250;
    return readingTime.ceil();
  }

  String upperFirstLetter(){
    return this[0].toUpperCase() + substring(1);
  }

  String upperFirstLetterWithSpace(){
    return split(RegExp(r'\s+')) // Split by multiple spaces
        .where((word) => word.isNotEmpty) // Remove empty words (extra spaces)
        .map((word) => word[0].toUpperCase() + word.substring(1)) // Capitalize first letter
        .join(' '); // Join words with single space
  }
}

extension StringNullableExt on String?{
  bool isNotEmptyOrNull(){
    if(this == null) return false;
    return this!.isNotEmpty;
  }
}