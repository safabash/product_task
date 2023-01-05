import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import '../../view/widgets/app_popups.dart';

class AppException {
  static void handleError(Object exception, context) {
    if (exception is DioError) {
      if (exception.type == DioErrorType.cancel) {
        AppPopUp.showToast(context, "Request Cancelled", Colors.red);
      } else if (exception.error is SocketException) {
        AppPopUp.showToast(context, 'no Internet connection', Colors.red);
      } else if (exception.response?.statusCode == 400) {
        AppPopUp.showToast(
            context, exception.response!.data['message'], Colors.red);
      } else if (exception.response?.statusCode == 404) {
        AppPopUp.showToast(
            context, exception.response!.data['message'], Colors.red);
      } else if (exception.type == DioErrorType.connectTimeout) {
        AppPopUp.showToast(context, "Connection timeout", Colors.red);
      } else if (exception.type == DioErrorType.receiveTimeout) {
        AppPopUp.showToast(context, "Receive timeout", Colors.red);
      } else if (exception.type == DioErrorType.sendTimeout) {
        AppPopUp.showToast(context, "Send time out", Colors.red);
      } else if (exception.type == DioErrorType.other) {
        AppPopUp.showToast(context, "Error Occured", Colors.red);
      } else if (exception.type == DioErrorType.response) {
        AppPopUp.showToast(
            context, "Error Occured with no response", Colors.red);
      }
    } else {
      AppPopUp.showToast(context, exception.toString(), Colors.red);
    }
  }
}
