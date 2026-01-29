String timeAgoSinceDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return "N/A";

  try {
    final dateTime = DateTime.parse(
      dateString,
    ).toLocal();
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return "just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? 'minute' : 'minutes'} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} ${diff.inHours == 1 ? 'hour' : 'hours'} ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'} ago";
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return "$months ${months == 1 ? 'month' : 'months'} ago";
    } else {
      final years = (diff.inDays / 365).floor();
      return "$years ${years == 1 ? 'year' : 'years'} ago";
    }
  } catch (e) {
    return "Invalid Date";
  }
}
