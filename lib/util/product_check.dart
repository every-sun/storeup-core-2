import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/product.dart';

/* 상품 리스트 */
String onlineOutOfStockType(Product product) {
  if (product.online == null) return '구매불가';
  if (!(product.isOnline || product.isNow)) return '구매불가';
  if (!product.online!.isPurchasable) return '구매불가';
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

/* 장바구니 */
String onlineCartOutOfStockType(Cart cart) {
  String result = onlineOutOfStockType(cart.product);
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

String deliveryCartOutOfStockType(Cart cart) {
  if (cart.product.delivery == null) return '주문불가';
  if (!cart.product.isDelivery) return '주문불가';
  if (cart.product.delivery!.isTemporarySoldOut) {
    return '일시품절';
  }
  if (cart.product.delivery!.isManageStock) {
    if (cart.product.delivery!.stockQuantity == 0) {
      return '품절';
    } else if (cart.product.delivery!.purchasableQuantityMin > 1 &&
        cart.product.delivery!.stockQuantity <
            cart.product.delivery!.purchasableQuantityMin) {
      return '재고부족';
    }
  }
  if (!cart.product.delivery!.isPurchasable) {
    return '주문불가';
  }
  return '';
}

String deliveryProductAddableCheck(DeliveryDetailInfo data) {
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
  if (!data.isPurchasable) {
    return '주문불가';
  }
  return '';
}

String deliveryProductOutOfStockType(DeliveryProductsByCategory data) {
  if (data.product == null) {
    return '주문불가';
  }
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
  if (!data.isPurchasable) {
    return '주문불가';
  }
  return '';
}
