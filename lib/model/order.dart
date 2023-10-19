import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/model/store.dart';

/* 주문 생성 */
class OrderRequestBody {
  OrderRequestBodyData data;
  dynamic addressId;
  dynamic shippingFeeSettingId;
  Customer customer;
  dynamic tenantId;
  List<OrderRequestItem> items;
  OrderRequestBody(
      {required this.data,
      required this.addressId,
      required this.shippingFeeSettingId,
      required this.customer,
      required this.tenantId,
      required this.items});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['data'] = data.toJson();
    body['address_id'] = addressId;
    body['shipping_fee_setting_id'] = shippingFeeSettingId;
    body['customer'] = customer.toJson();
    body['tenant_id'] = tenantId;
    body['items'] = items.map((e) => e.toJson()).toList();
    return body;
  }
}

class OrderRequestBodyData {
  dynamic brandId;
  dynamic orderNo;
  String orderType;
  String orderMethod;
  int orderShippingFee;
  int orderPriceAmount; // 상품,옵션 판매 금액
  bool isUseDiscountCoupon;
  int orderDiscountAmount;
  int orderCouponDiscountAmount;
  int orderCustomDiscountAmount;
  int orderAdditionalPaymentAmount;
  int orderPaymentAmount; // 할인,배송비를 합산한 최종 결제 (예상)금액
  bool isOnline;
  String? detailAddress;
  String? deliveryContact;
  Map<dynamic, dynamic> orderRequest;

  OrderRequestBodyData(
      {required this.brandId,
      required this.orderNo,
      required this.orderType,
      required this.orderMethod,
      required this.orderShippingFee,
      required this.orderPriceAmount,
      required this.isUseDiscountCoupon,
      required this.orderDiscountAmount,
      required this.orderCouponDiscountAmount,
      required this.orderCustomDiscountAmount,
      required this.orderAdditionalPaymentAmount,
      required this.orderPaymentAmount,
      required this.isOnline,
      required this.orderRequest,
      this.detailAddress,
      this.deliveryContact});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['brand_id'] = brandId;
    body['order_no'] = orderNo;
    body['order_type'] = orderType;
    body['order_method'] = orderMethod;
    body['order_shipping_fee'] = orderShippingFee;
    body['order_price_amount'] = orderPriceAmount;
    body['is_use_discount_coupon'] = isUseDiscountCoupon;
    body['order_discount_amount'] = orderDiscountAmount;
    body['order_coupon_discount_amount'] = orderCouponDiscountAmount;
    body['order_custom_discount_amount'] = orderCustomDiscountAmount;
    body['order_additional_payment_amount'] = orderAdditionalPaymentAmount;
    body['order_payment_amount'] = orderPaymentAmount;
    body['is_online'] = isOnline;
    body['order_request'] = orderRequest;
    body['detail_address'] = detailAddress;
    body['delivery_contact'] = deliveryContact;
    return body;
  }
}

// 주문생성 post 요청 응답데이터
class OrderRequestResponse {
  bool status;
  String message;
  Map<dynamic, dynamic>? data;
  OrderRequestResponse(
      {required this.status, required this.message, required this.data});
  factory OrderRequestResponse.fromJson(Map<String, dynamic> json) =>
      OrderRequestResponse(
          status: json['status'] ?? false,
          message: json['message'],
          data: json['data']);
}

class OrderRequestItem {
  dynamic productId;
  int quantity;
  List<CartOption>? options;

  OrderRequestItem(
      {required this.productId, required this.quantity, required this.options});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['product_id'] = productId;
    body['quantity'] = quantity;
    body['options'] =
        options != null ? options!.map((v) => v.toJson()).toList() : null;
    return body;
  }
}
/* ------- 주문 생성 ------- */

/* 주문내역 */
class OrderResponse {
  bool status;
  String message;
  OrderResponseData? data;
  OrderResponse(
      {required this.status, required this.message, required this.data});
  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? OrderResponseData.fromJson(json['data'])
          : null);
}

class OrderResponseData {
  List<Order> data;
  int total;
  OrderResponseData({required this.data, required this.total});
  factory OrderResponseData.fromJson(Map<String, dynamic> json) =>
      OrderResponseData(
          data: json['data'] != null
              ? List<Order>.from(json['data'].map((x) => Order.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Order {
  dynamic id;
  dynamic globalId;
  String orderNo;
  String orderType;
  String orderStatus;
  Map<dynamic, dynamic> orderRequest;
  int orderPriceAmount;
  int orderShippingFee;
  int orderPaymentAmount;
  int orderPaidAmount;
  int orderPaidShippingFee;
  int orderDiscountAmount;
  int orderCouponDiscountAmount;
  int orderAdditionalPaymentAmount;
  int orderRemainAmount;
  bool isPaid;
  bool isOnline;
  bool isReviewed;
  bool isUseDiscountCoupon;
  List<OrderPayment> payments;
  Customer customer;
  List<OrderItem> items;
  DateTime createdAt;
  OrderShippingDetail? shippingDetail;
  OrderDeliveryDetail? deliveryDetail;
  Order(
      {required this.id,
      required this.globalId,
      required this.orderNo,
      required this.orderType,
      required this.orderStatus,
      required this.orderRequest,
      required this.orderPriceAmount,
      required this.orderShippingFee,
      required this.orderPaymentAmount,
      required this.orderPaidAmount,
      required this.orderPaidShippingFee,
      required this.orderDiscountAmount,
      required this.orderCouponDiscountAmount,
      required this.orderAdditionalPaymentAmount,
      required this.orderRemainAmount,
      required this.isPaid,
      required this.isOnline,
      required this.isReviewed,
      required this.isUseDiscountCoupon,
      required this.payments,
      required this.customer,
      required this.items,
      required this.createdAt,
      required this.shippingDetail,
      required this.deliveryDetail});
  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        globalId: json['global_id'],
        orderNo: json['order_no'] ?? '',
        orderType: json['order_type'] ?? '',
        orderStatus: json['order_status'],
        orderRequest: json['order_request'],
        orderPriceAmount: json['order_price_amount'],
        orderShippingFee: json['order_shipping_fee'],
        orderPaymentAmount: json['order_payment_amount'],
        orderPaidAmount: json['order_paid_amount'],
        orderPaidShippingFee: json['order_paid_shipping_fee'],
        orderDiscountAmount: json['order_discount_amount'],
        orderCouponDiscountAmount: json['order_coupon_discount_amount'],
        orderAdditionalPaymentAmount: json['order_additional_payment_amount'],
        orderRemainAmount: json['order_remain_amount'],
        isPaid: json['is_paid'],
        isOnline: json['is_online'],
        isReviewed: json['is_reviewed'],
        isUseDiscountCoupon: json['is_use_discount_coupon'],
        payments: json['payments'] != null
            ? List<OrderPayment>.from(
                json['payments'].map((x) => OrderPayment.fromJson(x)))
            : [],
        customer: Customer.fromJson(json['customer']),
        items: json['items'] != null
            ? List<OrderItem>.from(
                json['items'].map((e) => OrderItem.fromJson(e)))
            : [],
        createdAt: DateTime.parse(
          json['created_at'],
        ),
        shippingDetail: json['shipping_detail'] != null
            ? OrderShippingDetail.fromJson(json['shipping_detail'])
            : null,
        deliveryDetail: json['delivery_detail'] != null
            ? OrderDeliveryDetail.fromJson(json['delivery_detail'])
            : null,
      );
}

class OrderDeliveryDetail {
  dynamic tenantId;
  String? storeName;
  String deliveryStatus;
  int deliveryFee;
  dynamic orderTime;
  int paidDeliveryFee;
  String pickupAddress;
  Map? receiver;
  OrderDeliveryDetail(
      {required this.tenantId,
      required this.storeName,
      required this.deliveryStatus,
      required this.deliveryFee,
      required this.orderTime,
      required this.paidDeliveryFee,
      required this.pickupAddress,
      required this.receiver});
  factory OrderDeliveryDetail.fromJson(Map<String, dynamic> json) =>
      OrderDeliveryDetail(
          tenantId: json['tenant_id'],
          storeName: json['store_name'],
          deliveryStatus: json['delivery_status'] ?? '',
          orderTime: json['order_time'],
          deliveryFee: json['delivery_fee'],
          paidDeliveryFee: json['paid_delivery_fee'],
          pickupAddress: json['pickup_address'] ?? '',
          receiver: json['receiver']);
}

class OrderShippingDetail {
  Map<String, dynamic>?
      receiver; // {'name':'', 'contact': '', 'zipcode': '', 'address1': '', 'address2': ''}
  dynamic trackingNo;
  String shoppingStatus;
  dynamic deliveredAt;
  Map? carrier;
  OrderShippingDetail(
      {required this.receiver,
      required this.trackingNo,
      required this.shoppingStatus,
      required this.deliveredAt,
      required this.carrier});
  factory OrderShippingDetail.fromJson(Map<String, dynamic> json) =>
      OrderShippingDetail(
          receiver: json['receiver'],
          trackingNo: json['tracking_no'],
          shoppingStatus: json['shopping_status'] ?? '',
          deliveredAt: json['delivered_at'],
          carrier: json['carrier']);
}

class OrderItem {
  dynamic id;
  dynamic orderId;
  dynamic globalId;
  String itemNo;
  String orderNo;
  String orderStatus;
  String orderType;
  bool isCanceled;
  bool isConfirmedPurchase;
  bool isPassed;
  bool isPurchasable;
  int itemAdditionalPaymentAmount;
  int itemCouponDiscountAmount;
  int itemCustomDiscountAmount;
  int itemCustomDiscountPercentage;
  int itemPaymentAmount;
  int itemPriceAmount;
  DateTime? confirmedPurchaseAt;
  List<CartOption> options;
  DateTime createdAt;
  int productQuantity;
  int productPrice;
  int optionsPrice;
  bool isReviewed;
  Product? product;
  Store? store;
  Review? review;
  List<dynamic> currentClaim;
  List<OrderPayment> payments;
  OrderItem(
      {required this.id,
      required this.orderId,
      required this.globalId,
      required this.itemNo,
      required this.orderNo,
      required this.orderStatus,
      required this.orderType,
      required this.isCanceled,
      required this.isConfirmedPurchase,
      required this.isPassed,
      required this.isPurchasable,
      required this.itemAdditionalPaymentAmount,
      required this.itemCouponDiscountAmount,
      required this.itemCustomDiscountAmount,
      required this.itemCustomDiscountPercentage,
      required this.itemPaymentAmount,
      required this.itemPriceAmount,
      required this.confirmedPurchaseAt,
      required this.options,
      required this.createdAt,
      required this.productQuantity,
      required this.productPrice,
      required this.optionsPrice,
      required this.isReviewed,
      required this.product,
      required this.store,
      required this.review,
      required this.currentClaim,
      required this.payments});
  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        orderId: json['order_id'],
        globalId: json['global_id'],
        itemNo: json['item_no'] ?? '',
        orderNo: json['order_no'] ?? '',
        orderStatus: json['order_status'] ?? '',
        orderType: json['order_type'],
        isCanceled: json['is_canceled'],
        isConfirmedPurchase: json['is_confirmed_purchase'],
        isPassed: json['is_passed'],
        isPurchasable: json['is_purchasable'],
        itemAdditionalPaymentAmount: json['item_additional_payment_amount'],
        itemCouponDiscountAmount: json['item_coupon_discount_amount'],
        itemCustomDiscountAmount: json['item_custom_discount_amount'],
        itemCustomDiscountPercentage: json['item_custom_discount_percentage'],
        itemPaymentAmount: json['item_payment_amount'],
        itemPriceAmount: json['item_price_amount'],
        confirmedPurchaseAt: json['confirmed_purchase_at'] != null
            ? DateTime.parse(json['confirmed_purchase_at'])
            : null,
        options: json['options'] != null
            ? List<CartOption>.from(
                json['options'].map((e) => CartOption.fromJson(e)))
            : [],
        createdAt: DateTime.parse(json['created_at']),
        productQuantity: json['product_quantity'],
        productPrice: json['product_price'],
        optionsPrice: json['options_price'],
        isReviewed: json['is_reviewed'],
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        store: json['store'] != null ? Store.fromJson(json['store']) : null,
        review: json['review'] != null ? Review.fromJson(json['review']) : null,
        currentClaim: json['current_claim'] ?? [],
        payments: json['payments'] != null
            ? List<OrderPayment>.from(
                json['payments'].map((x) => OrderPayment.fromJson(x)))
            : [],
      );
}

class OrderPayment {
  dynamic id;
  String approvedDate;
  String approvedTime;
  String cardNumber;
  String paymentMethod;
  int paymentAmount;
  int remainAmount;
  dynamic virtualAccountData;
  Map? data;
  OrderPayment(
      {required this.id,
      required this.approvedDate,
      required this.approvedTime,
      required this.cardNumber,
      required this.paymentMethod,
      required this.paymentAmount,
      required this.remainAmount,
      required this.virtualAccountData,
      required this.data});
  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
        id: json['id'],
        approvedDate: json['approved_date'] ?? '',
        approvedTime: json['approved_time'] ?? '',
        cardNumber: json['card_number'] ?? '',
        paymentMethod: json['payment_method'] ?? '',
        paymentAmount: json['payment_amount'],
        remainAmount: json['remain_amount'],
        virtualAccountData: json['virtual_account_data'],
        data: json['data'],
      );
}
