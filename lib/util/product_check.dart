import 'package:user_core2/model/product.dart';

String productOutOfStockType(Product product) {
  if (product.online.isManageStock) {
    if (product.online.stockQuantity == 0) {
      return '품절';
    } else if (product.online.purchasableQuantityMin > 1 &&
        product.online.stockQuantity < product.online.purchasableQuantityMin) {
      return '재고부족';
    }
  }
  if (product.online.isTemporarySoldOut) {
    return '일시품절';
  }
  return '';
}
