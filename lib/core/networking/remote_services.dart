import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spex/core/di/sl.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/feature/authentication/model/user_model.dart';
import 'package:spex/feature/category/model/category_model.dart';
import 'package:spex/feature/category/model/pagination_rresponse_model.dart';
import 'package:spex/feature/home/model/product_model.dart';
import 'package:spex/feature/product_details/model/mini_product_model.dart';
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

  Future<Either<String,User> > login(String email, String password)async{
    try {
      final body = {
        'email': email,
        'password': password
      };
       final response = await getIt<Network>().getDataWithBodyAndQuery(
        body,
        null,
        ServicesConstants.loginEndPoint
        
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        User user = User.fromJson(resp);
        return right(user);
      }
      else if (response.statusCode == 401) {
        return left(LocaleKeys.api_replay_message_wrong_data.tr());
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map) {
        return left(e.response!.data["error"] ?? e.toString());
      }
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
  
  Future<Either<String,String> > register(String name, String email, String password, )async{
    try {
      final body = { 
        'name': name,
        'email': email,
        'password': password
      };
       final response = await getIt<Network>().getDataWithBodyAndQuery(
        body,
        null,
        ServicesConstants.registerEndPoint
        
      );
      if (response.statusCode == 200) {
        return right(LocaleKeys.auth_register_success.tr());
      }
      else {
        return left(response.data["error"]);
      }
      // return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map) {
        return left(e.response!.data["error"] ?? e.toString());
      }
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

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
        queryParameters: {'q': query},
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

  Future<Either<String, PaginationResponseModel<MiniProductModel>>> getPromotions({int page = 1}) async {
    try {
      Map<String, dynamic> queryParameters = {
        // 'on_sale': true,
        // 'status': 'publish',
        'per_page': AppConstants.perPage,
        "page": page,
        // 'orderby': 'date',
        // 'order': 'desc',
      };
      final response = await getIt<Network>().getData(
        ServicesConstants.getPromotionsEndPoint,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        PaginationResponseModel<MiniProductModel> paginationResponseModel =
            PaginationResponseModel.fromJson(
              resp,
              (json) => MiniProductModel.fromJson(json),
            );
        return right(paginationResponseModel);
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, PaginationResponseModel<MiniProductModel>>>
  getBestSellers({int page = 1}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'page': page,
        'per_page': AppConstants.perPage,
      };
      final response = await getIt<Network>().getData(
        ServicesConstants.getBestSellersEndPoint,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        PaginationResponseModel<MiniProductModel> paginationResponseModel =
            PaginationResponseModel.fromJson(
              resp,
              (json) => MiniProductModel.fromJson(json),
            );
        return right(paginationResponseModel);
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, SimplifiedProductModel>> getProductDetails(
    String sku,
  )
  async {
    try {
      Map<String, dynamic> queryParameters = {'sku': sku};
      final response = await getIt<Network>().getData(
        ServicesConstants.getProductsEndPoint,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        if (resp is List && resp.isNotEmpty) {
          ProductModel product = ProductModel.fromJson(resp[0]);
          SimplifiedProductModel simplifiedProduct = product.toSimplified();
          return right(simplifiedProduct);
        }
        return left("Product not found");
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, PaginationResponseModel<MiniProductModel>>>
  getCategoryProducts(int categoryId, {int page = 1, int perPage = 20})
  async {
    try {
      final response = await getIt<Network>().postData(
        ServicesConstants.categoryProductsEndPoint,
        options: Options(
          headers: {
            'X-Category-Id': categoryId,
            'X-Per-Page': perPage,
            'X-Page': page,
          },
        ),
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        PaginationResponseModel<MiniProductModel> products =
            PaginationResponseModel<MiniProductModel>.fromJson(
              resp,
              (json) => MiniProductModel.fromJson(json),
            );
        return right(products);
      }
      return left(await responseOfStatusCode(response.statusCode));
    } on DioException catch (e) {
      return left(await responseOfStatusCode(e.response?.statusCode));
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<SimplifiedProductModel>>> getListOfProducts(
    List<int> productIds,
  ) async {
    try {
      final response = await getIt<Network>().getDataWithBodyAndQuery(
        {'ids': productIds},
        null,
        ServicesConstants.productsListEndPoint,
      );
      if (response.statusCode == 200) {
        final resp = response.data;
        List<MiniProductModel> products = (resp['products'] as List)
            .map((x) => MiniProductModel.fromJson(x))
            .toList();

        List<SimplifiedProductModel> simplifiedProducts = products
            .map((x) => x.toSimplifiedProduct())
            .toList();
        return right(simplifiedProducts);
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
