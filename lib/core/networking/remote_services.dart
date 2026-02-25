import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/feature/home/model/category_model.dart';
import 'package:spex/feature/search/model/search_item_model.dart';
import '../../generated/locale_keys.g.dart';
import 'network.dart';

class RemoteServices {
  RemoteServices();

  // Future<Either<String, String>> sendOTPCodeToUser({
  //   bool isRegister = true,
  //   required String phone,
  // })
  // async {
  //   String otpCode = '';
  //   try {
  //     otpCode = await generateOTP();
  //
  //     String message = isRegister == true
  //         ? ValuesOfAllApp.registerMessage
  //         : ValuesOfAllApp.resetPasswordMessage;
  //
  //     Map<String, dynamic> queryParams = {
  //       // "bearerTokens" : ValuesOfAllApp.optCodeText,
  //       // "sender" : 'SMAT.SA',
  //       // "recipients" : formatSaudiPhone(phone),
  //       // "body" : '$message $otpCode',
  //       "user": phone,
  //       "message": '$message $otpCode',
  //     };
  //     //
  //     await network.getDataWithQuery(queryParams, ServicesConstants.otpUrl);
  //
  //     print('$message $otpCode');
  //     return right(otpCode);
  //   } catch (e) {
  //     left(otpCode);
  //   }
  //   return left(otpCode);
  // }

  String formatSaudiPhone(String phone) {
    if (phone.startsWith('966')) {
      return phone;
    } else {
      return '966$phone';
    }
  } 
   String formatEGPPhone(String phone) {
    if (phone.startsWith('2')) {
      return phone;
    } else {
      return '2$phone';
    }
  }

  Future<String> generateOTP() async {
    final Random random = Random();
    String otp = '';

    for (int i = 0; i < 4; i++) {
      otp += random.nextInt(10).toString();
    }

    return otp;
  }

  // Future<Either<String, User>> logIn(String phone, String password) async {
  //   // try {
  //
  //   String jsonString = json.encode({
  //     'user': phone,
  //     'password': password,
  //     'type': UserType.appUser,
  //   });
  //   Map<String, dynamic> queryParams = {};
  //   final response = await network.getDataWithBodyAndQuery(
  //     jsonString,
  //     queryParams,
  //     ServicesConstants.loginEndPoint,
  //   );
  //   if (response.statusCode == 200) {
  //     final resp = response.data;
  //     if (resp is String) {
  //       if (resp == ReturnMessage.noUser) {
  //         return left(LocaleKeys.api_replay_message_user_not_found.tr());
  //       } else if (resp == ReturnMessage.wrongPassword) {
  //         return left(LocaleKeys.api_replay_message_wrong_password.tr());
  //       } else if (resp == ReturnMessage.notActive) {
  //         return left(LocaleKeys.api_replay_message_not_active.tr());
  //       }
  //     }
  //     User user = User.fromJson(resp[0]);
  //     final token = await getFireBaseToken();
  //     if (token != null && token.isNotEmpty && token != user.fcmtoken) {
  //       user.fcmtoken = token;
  //       getIt<AuthCubit>().user = user;
  //       await updateFCMToken(token);
  //     }
  //     await getAccessToken();
  //     await getIt<AuthCubit>().initSignalR();
  //     FirebaseMessaging.instance.subscribeToTopic(UserType.appUser.toString());
  //     return right(user);
  //   }
  //   return left(await responseOfStatusCode(response.statusCode));
  //
  //   // } on DioException catch (e) {
  //   //   return left(await responseOfStatusCode( e.response?.statusCode) ,
  //   //   );
  //   // } catch (e) {
  //   //   return left(e.toString());
  //   // }
  // }

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await getIt<Network>().getData(
        ServicesConstants.getCategoriesEndPoint,
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        List<CategoryModel> categories = (resp as List)
            .map((x) => CategoryModel.fromJson(x))
            .toList();
        return right(categories);
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<SearchItemModel>>> search(String query) async {
    try {
      final response = await getIt<Network>().getData(
        ServicesConstants.searchEndPoint,
        queryParameters: {
          'q': query,
        },
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        List<SearchItemModel> searchItems = (resp as List)
            .map((x) => SearchItemModel.fromJson(x))
            .toList();
        return right(searchItems);
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }



}

Future<String> responseOfStatusCode(int? statusCode) async {
  switch (statusCode) {
    case 400:
    case 401:
    case 403:
      return LocaleKeys.api_replay_message_bad_request.tr();
    case 404:
      return LocaleKeys.api_replay_message_request_not_found.tr();
    case 500:
      return LocaleKeys.api_replay_message_server_error.tr();
    default:
      return LocaleKeys.api_replay_message_unknown_error_message.tr();
  }
}
