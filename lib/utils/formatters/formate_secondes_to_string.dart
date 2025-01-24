String formateSecondesToString(int seconds) {
  var hourse = (seconds / (60 * 60)).floor().toString();
  var minuts = ((seconds / 60).floor() % 60).toString();
  var resultsSeconds = (seconds % 60).toString();

  if (hourse.length <= 1) {
    hourse = "0$hourse";
  }
  if (minuts.length <= 1) {
    minuts = "0$minuts";
  }
  if (resultsSeconds.length <= 1) {
    resultsSeconds = "0$resultsSeconds";
  }
  return '$hourse:$minuts:$resultsSeconds';
}
