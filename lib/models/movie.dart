class Movie {
  int id;
  String title;
  String url;
  String thumbnail;
  String poster;
  String description;
  String quality;
  String downloadUrl;
  String actors;
  String directors;
  String writers;
  String crew;
  String rating;
  String releaseDate;
  String countries;
  String genres;
  String runTime;
  bool isDownloaded;
  Movie({this.isDownloaded = false});
  Movie.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        url = map["url"],
        downloadUrl = map['downloadUrl'],
        title = map['title'],
        thumbnail = map['thumbnail'],
        description = map['description'],
        actors = map['actors'],
        isDownloaded = map['isDownloaded'];
  Map<String, dynamic> toMap() {
    return {
      "downloadUrl": downloadUrl,
      "id": id,
      "title": title,
      "url": url,
      "thumbnail": thumbnail,
      "poster": poster,
      "description": description,
      "actors": actors,
      "isDownloaded": isDownloaded
    };
  }
}
