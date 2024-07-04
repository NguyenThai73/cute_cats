// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:cat_lover/model/buy.point.select.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'buy.fish.cubit.state.dart';

class BuyFishCubit extends Cubit<BuyFishCubitState> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final bool _kAutoConsume = Platform.isIOS || true;
  String _kConsumableId = "";
  bool verifyPurchase = false;

  BuyFishCubit() : super(const BuyFishCubitState(status: BuyFishStatus.initial, buyOptionModel: null)) {
    _subscription = inAppPurchase.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      print("onError: ${error}");
    });
  }

  purchaseProduct(BuyOptionModel buyOptionModelItem) async {
    emit(state.copyWith(status: BuyFishStatus.loading, buyOptionModel: buyOptionModelItem));
    try {
      late PurchaseParam purchaseParam;
      _kConsumableId = buyOptionModelItem.productId ?? "";
      bool available = await inAppPurchase.isAvailable();
      if (!available) {
        emit(state.copyWith(
          status: BuyFishStatus.error,
        ));
        return;
      }
      final ProductDetailsResponse productDetailsResponse = await inAppPurchase.queryProductDetails({_kConsumableId});
      if (productDetailsResponse.notFoundIDs.contains(_kConsumableId)) {
        emit(state.copyWith(
          status: BuyFishStatus.error,
        ));
        return;
      }
      final ProductDetails productDetails = productDetailsResponse.productDetails.first;
      if (Platform.isAndroid) {
        purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails,
        );
      } else {
        purchaseParam = AppStorePurchaseParam(
          productDetails: productDetails,
        );
      }
      await inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
    } catch (e) {
      emit(state.copyWith(status: BuyFishStatus.error));
    }
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        return;
      } else {
        if (purchaseDetails.status == PurchaseStatus.canceled) {
          emit(state.copyWith(
            status: BuyFishStatus.initial,
          ));
        }
        if (purchaseDetails.status == PurchaseStatus.error) {
          emit(state.copyWith(
            status: BuyFishStatus.error,
          ));
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
          if (state.status == BuyFishStatus.loading) {
            if (verifyPurchase) {
              verifyPurchase = false;
              emit(state.copyWith(
                status: BuyFishStatus.success,
              ));
            } else {
              emit(state.copyWith(
                status: BuyFishStatus.initial,
              ));
            }
          }
        }
      }
    }
  }

  @override
  Future<void> close() async {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.close();
  }
}

List<BuyOptionModel> listBuyOption = [
  BuyOptionModel(id: 1, amount: 0.5, fish: 10, bonus: 0, productId: "buy10now"),
  BuyOptionModel(id: 2, amount: 1, fish: 20, bonus: 10, productId: "buy20now"),
  BuyOptionModel(id: 3, amount: 2.5, fish: 50, bonus: 30, productId: "buy50now"),
  BuyOptionModel(id: 4, amount: 5, fish: 100, bonus: 70, productId: "buy100now")
];
