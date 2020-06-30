import '../model/travel_tab_model.dart';

import 'http_request.dart';

class GLTravelTabRequest {
  static Future<List<GLTravelTabModel>> getTabData() async {
    const TAB_URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';
    final res = await HttpRequest.request(TAB_URL);
    final tabs = res['tabs'];
    List<GLTravelTabModel> tabsList = [];
    for(var json in tabs) {
      tabsList.add(GLTravelTabModel.fromJson(json));
    }
    return tabsList;
  }
}