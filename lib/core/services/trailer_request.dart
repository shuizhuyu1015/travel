import 'http_request.dart';
import '../model/trailer_model.dart';

class GLTrailerRequest {
  static Future<List<GLTrailerModel>> getTrailers() async {
    const String url = 'https://www.imovietrailer.com/superhero/index/movie/hot?type=trailer&qq=1026540422';
    final res = await HttpRequest.request(url, method: 'POST');
    List<GLTrailerModel> trailers = [];
    if(res['status'] == 200) {
      for(var item in res['data']) {
        trailers.add(GLTrailerModel.fromJson(item));
      }
    }
    return trailers;
  }
}