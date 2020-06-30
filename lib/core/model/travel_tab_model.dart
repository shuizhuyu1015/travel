class GLTravelTabModel {
  String labelName;
  String groupChannelCode;

  GLTravelTabModel({this.labelName, this.groupChannelCode});

  GLTravelTabModel.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
