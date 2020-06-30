import 'package:dio/dio.dart';
import 'config.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.BASE_URL, connectTimeout: HttpConfig.TIMEOUT);
  static final Dio dio = Dio(baseOptions);

  // 外部调用方法
  static Future<T> request<T>(String url, {
      String method = 'get',
      Map<String, dynamic> params,
      Interceptor inter
  }) async {

    // 1.创建单独配置
    final options = Options(method: method);

    // 全局拦截器
    Interceptor dInter = InterceptorsWrapper(
      onRequest: (options) {
        return options;
      },
      onResponse: (response) {
        return response;
      },
      onError: (err) {
        return err;
      }
    );
    List<Interceptor> inters = [dInter];
    // 添加单独拦截器
    if(inter != null){
      inters.add(inter);
    }
    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);

    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }
}