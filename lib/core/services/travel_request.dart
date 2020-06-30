import 'http_request.dart';
import 'config.dart';

class GLTravelRequest {
  static Future getData(String groupChannelCode, int pageIndex) async {
    Map params = TravelConfig.params;
    Map pageParam = params['pagePara'];
    pageParam['pageIndex'] = pageIndex;
    params['groupChannelCode'] = groupChannelCode;
    print(params);
    final res = await HttpRequest.request(TravelConfig.URL, method: 'post', params: params);
    print(res);
  }
}