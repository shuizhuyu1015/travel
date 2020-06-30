class HttpConfig {
  static const String BASE_URL = 'http://www.devio.org';
  static const int TIMEOUT = 20000;
}

class WebViewConfig {
  static const List<String> CATCH_URLS = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5/you/',
  ];
}

class TravelConfig {
  static const URL = "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";
  static Map<String, dynamic> params = {
    "districtId": -1,
    "groupChannelCode": "tourphoto_global1",
    "type": null,
    "lat": -180,
    "lon": -180,
    "locatedDistrictId": 0,
    "pagePara": {
      "pageIndex": 1,
      "pageSize": 10,
      "sortType": 9,
      "sortDirection": 0
    },
    "imageCutType": 1,
    "head": {},
    "contentType": "json"
  };
}