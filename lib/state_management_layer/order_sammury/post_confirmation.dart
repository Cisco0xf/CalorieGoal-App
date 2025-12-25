import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/data_layer/product_model.dart';
import 'package:flowapp/state_management_layer/order_sammury/cart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class PostConfirmation extends StateNotifier<bool> {
  PostConfirmation({required this.ref}) : super(false);

  final Ref ref;
  final String targetEndPoint = dotenv.env["POST_END_POINT"] ?? "NOT FOUND";

  Future<void> get postConfirmation async {
    try {
      state = true;
      final List<ProductModel> cartProducts =
          ref.read(cartProvider.notifier).cartData;

      Map<String, dynamic> body = <String, dynamic>{
        "items": <Map>[
          for (int i = 0; i < cartProducts.length; i++) ...{
            <String, dynamic>{
              "name": cartProducts[i].name,
              "total_price": (12 * cartProducts[i].quantity).floor(),
              "quantity": cartProducts[i].quantity,
            },
          }
        ],
      };

      log("Target Body : $body");

      final String usedBody = json.encode(body);

      final Uri url = Uri.parse(targetEndPoint);

      final reseponse = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: usedBody,
      );

      if (reseponse.statusCode == 200) {
        log("Target Posted successfully !!");
        log("Reponse Body : ${reseponse.body}");
        showToastification(
          msg: "Data has been posted to target successfully !!",
          type: ToastificationType.success,
          duration: 6000,
        );
      }
    } on SocketException {
      log("Internet error");
    } catch (error) {
      log("Error while posing the Data");
      log(error.toString());
    } finally {
      state = false;
      ref.read(cartProvider.notifier).clearCart;
      popRoute();
    }
  }
}

final confrimProivder = StateNotifierProvider<PostConfirmation, bool>(
  (ref) {
    return PostConfirmation(ref: ref);
  },
);
