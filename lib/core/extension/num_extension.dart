import 'package:travel/ui/shared/size_fit.dart';

extension NumFit on num {
  double get px {
    return GLSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return GLSizeFit.setRpx(this.toDouble());
  }
}