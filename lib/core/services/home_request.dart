import 'http_request.dart';
import '../model/home_model.dart';

class GLHomeRequest {
  static Future<GLHomeModel> getHomeData() async {
    const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
    final res = await HttpRequest.request(HOME_URL);
    GLHomeModel homeModel = GLHomeModel.fromJson(res);
    return homeModel;
  }
}
