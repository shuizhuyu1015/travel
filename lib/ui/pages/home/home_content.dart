import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:travel/core/model/home_model.dart';
import 'package:travel/core/services/home_request.dart';
import 'package:travel/core/extension/num_extension.dart';
import 'package:travel/ui/shared/size_fit.dart';
import 'package:travel/ui/widgets/webview.dart';

import 'home_content_activity.dart';
import 'home_content_grid.dart';
import 'home_content_subnav.dart';

class GLHomeContent extends StatefulWidget {
  @override
  _GLHomeContentState createState() => _GLHomeContentState();
}

class _GLHomeContentState extends State<GLHomeContent> {

  EasyRefreshController _controller;

  double appBarAlpha = 0.0;
  final double navHeight = GLSizeFit.statusHeight + 44;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = EasyRefreshController();
  }

  /// 监听滚动回调
  void _onScroll(double offset) {
    double alpha = offset / navHeight;
    if(alpha < 0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GLHomeModel>(
      future: GLHomeRequest.getHomeData(),
      builder: (ctx, snapshot) {
        if(snapshot.hasError) return Center(child: Text('请求失败'),);
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

        GLHomeModel homeModel = snapshot.data;

        return Stack(
          children: <Widget>[
            NotificationListener(
              child: EasyRefresh(
                controller: _controller,
                onRefresh: () async {
                  GLHomeModel model = await GLHomeRequest.getHomeData();
                  setState(() {
                    homeModel = model;
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      buildBanner(homeModel.bannerList),
                      buildLocalNav(context, homeModel.localNavList),
                      buildGridNav(context, homeModel.gridNav),
                      buildSubNav(context, homeModel.subNavList),
                      buildSalesBox(context, homeModel.salesBox)
                    ],
                  ),
                ),
              ),
              onNotification: (scrollNotification) {
                if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
            ),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: navHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, GLSizeFit.statusHeight, 15, 0),
                  child: Center(
                    child: Text('首页', style: Theme.of(context).textTheme.headline2.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),)
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  // banner
  Widget buildBanner(List<GLHomeBaseModel> bannerList) {
    return Container(
      height: 160.px,
      child: Swiper(
        autoplay: true,
        itemCount: bannerList.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            child: Image.network(bannerList[index].icon, fit: BoxFit.cover,),
            onTap: () {
              Navigator.of(context).pushNamed(GLWebView.routeName, arguments: bannerList[index]);
            },
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  // 周边游导航
  Widget buildLocalNav(BuildContext context, List<GLHomeBaseModel> localNavList) {
    if(localNavList.length == 0) return null;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.px, horizontal: 8.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.px)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(localNavList.length, (index) {
            return Expanded(
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    Image.network(localNavList[index].icon, width: 32.px, height: 32.px,),
                    Text(localNavList[index].title, style: TextStyle(fontSize: 12),)
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(GLWebView.routeName, arguments: localNavList[index]);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}