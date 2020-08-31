class GLTrailerModel {
  String id;
  String name;
  String poster;
  String cover;
  String trailer;
  double score;
  int prisedCounts;
  String basicInfo;
  String originalName;
  String releaseDate;
  String totalTime;
  String plotDesc;
  String directors;
  String actors;
  String plotPics;
  String createTime;

  GLTrailerModel(
      {this.id,
        this.name,
        this.poster,
        this.cover,
        this.trailer,
        this.score,
        this.prisedCounts,
        this.basicInfo,
        this.originalName,
        this.releaseDate,
        this.totalTime,
        this.plotDesc,
        this.directors,
        this.actors,
        this.plotPics,
        this.createTime});

  GLTrailerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    poster = json['poster'];
    cover = json['cover'];
    trailer = json['trailer'];
    score = json['score'];
    prisedCounts = json['prisedCounts'];
    basicInfo = json['basicInfo'];
    originalName = json['originalName'];
    releaseDate = json['releaseDate'];
    totalTime = json['totalTime'];
    plotDesc = json['plotDesc'];
    directors = json['directors'];
    actors = json['actors'];
    plotPics = json['plotPics'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster'] = this.poster;
    data['cover'] = this.cover;
    data['trailer'] = this.trailer;
    data['score'] = this.score;
    data['prisedCounts'] = this.prisedCounts;
    data['basicInfo'] = this.basicInfo;
    data['originalName'] = this.originalName;
    data['releaseDate'] = this.releaseDate;
    data['totalTime'] = this.totalTime;
    data['plotDesc'] = this.plotDesc;
    data['directors'] = this.directors;
    data['actors'] = this.actors;
    data['plotPics'] = this.plotPics;
    data['createTime'] = this.createTime;
    return data;
  }
}
