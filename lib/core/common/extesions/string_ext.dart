extension StringExt on String{
  int toReadingTime(){
    final wordsCount = split(RegExp(r'\s+')).length;
    // Reading speed = distance / time
    // Average reading speed is between 200 and 300 so i get 250
    final readingTime = wordsCount / 250;
    return readingTime.ceil();
  }
}