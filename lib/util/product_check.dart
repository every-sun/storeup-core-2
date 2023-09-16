import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/product.dart';

/* 상품 리스트 */
String productOutOfStockType(Product product) {
  if (product.online!.isTemporarySoldOut) {
    return '일시품절';
  }
  if (product.online!.isManageStock) {
    if (product.online!.stockQuantity == 0) {
      return '품절';
    } else if (product.online!.purchasableQuantityMin > 1 &&
        product.online!.stockQuantity <
            product.online!.purchasableQuantityMin) {
      return '재고부족';
    }
  }
  return '';
}

String deliveryProductOutOfStockType(dynamic data) {
  if (data.isTemporarySoldOut) {
    return '일시품절';
  }
  if (data.isManageStock) {
    if (data.stockQuantity == 0) {
      return '품절';
    } else if (data.purchasableQuantityMin > 1 &&
        data.stockQuantity < data.purchasableQuantityMin) {
      return '재고부족';
    }
  }
  return '';
}

/* 장바구니 */
String cartOutOfStockType(Cart cart) {
  String result = productOutOfStockType(cart.product);
  if (result == '') {
    if (cart.product.online!.isManageStock &&
        cart.product.online!.stockQuantity < cart.quantity) {
      result = '재고부족';
    } else if (!cart.isPurchasable) {
      result = '구매불가';
    }
  }
  return result;
}
