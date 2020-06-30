class GLHomeConfigModel {
  String searchUrl;

  GLHomeConfigModel({this.searchUrl});

  GLHomeConfigModel.fromJson(Map<String, dynamic> json) {
    searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this.searchUrl;
    return data;
  }
}


class GLHomeBaseModel {
  String icon;
  String title;
  String url;
  String statusBarColor;
  bool hideAppBar;

  GLHomeBaseModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  GLHomeBaseModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}


class GLHomeGridItemModel {
  String startColor;
  String endColor;
  GLHomeBaseModel mainItem;
  GLHomeBaseModel item1;
  GLHomeBaseModel item2;
  GLHomeBaseModel item3;
  GLHomeBaseModel item4;

  GLHomeGridItemModel({this.startColor, this.endColor, this.mainItem, this.item1,
    this.item2, this.item3, this.item4});

  GLHomeGridItemModel.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null ? GLHomeBaseModel.fromJson(json['mainItem']) : null;
    item1 = json['item1'] != null ? GLHomeBaseModel.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? GLHomeBaseModel.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? GLHomeBaseModel.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? GLHomeBaseModel.fromJson(json['item4']) : null;
  }
}


class GLHomeGridModel {
  GLHomeGridItemModel hotel;
  GLHomeGridItemModel flight;
  GLHomeGridItemModel travel;

  GLHomeGridModel({this.hotel, this.flight, this.travel});

  GLHomeGridModel.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? GLHomeGridItemModel.fromJson(json['hotel']) : null;
    flight = json['flight'] != null ? GLHomeGridItemModel.fromJson(json['flight']) : null;
    travel = json['travel'] != null ? GLHomeGridItemModel.fromJson(json['travel']) : null;
  }
}


class GLHomeSalesModel {
  String icon;
  String moreUrl;
  GLHomeBaseModel bigCard1;
  GLHomeBaseModel bigCard2;
  GLHomeBaseModel smallCard1;
  GLHomeBaseModel smallCard2;
  GLHomeBaseModel smallCard3;
  GLHomeBaseModel smallCard4;

  GLHomeSalesModel({
    this.icon,
    this.moreUrl,
    this.bigCard1,
    this.bigCard2,
    this.smallCard1,
    this.smallCard2,
    this.smallCard3,
    this.smallCard4
  });

  GLHomeSalesModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    moreUrl = json['moreUrl'];
    bigCard1 = json['bigCard1'] != null ? GLHomeBaseModel.fromJson(json['bigCard1']) : null;
    bigCard2 = json['bigCard2'] != null ? GLHomeBaseModel.fromJson(json['bigCard2']) : null;
    smallCard1 = json['smallCard1'] != null ? GLHomeBaseModel.fromJson(json['smallCard1']) : null;
    smallCard2 = json['smallCard2'] != null ? GLHomeBaseModel.fromJson(json['smallCard2']) : null;
    smallCard3 = json['smallCard3'] != null ? GLHomeBaseModel.fromJson(json['smallCard3']) : null;
    smallCard4 = json['smallCard4'] != null ? GLHomeBaseModel.fromJson(json['smallCard4']) : null;
  }
}


class GLHomeModel {
  GLHomeConfigModel config;
  List<GLHomeBaseModel> bannerList;
  List<GLHomeBaseModel> localNavList;
  List<GLHomeBaseModel> subNavList;
  GLHomeGridModel gridNav;
  GLHomeSalesModel salesBox;

  GLHomeModel.fromJson(Map<String, dynamic> json) {
    config = GLHomeConfigModel.fromJson(json['config']);
    bannerList = (json['bannerList'] as List).map((item) => GLHomeBaseModel.fromJson(item)).toList();
    localNavList = (json['localNavList'] as List).map((item) => GLHomeBaseModel.fromJson(item)).toList();
    subNavList = (json['subNavList'] as List).map((item) => GLHomeBaseModel.fromJson(item)).toList();
    gridNav = GLHomeGridModel.fromJson(json['gridNav']);
    salesBox = GLHomeSalesModel.fromJson(json['salesBox']);
  }
}