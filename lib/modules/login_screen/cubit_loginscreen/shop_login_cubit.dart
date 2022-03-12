import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit_loginscreen/shop_login_state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper_shop.dart';




class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? _loginModel;

  void userLogin({
  required String email,
  required String password
}) {
    emit(ShopLoginLoading());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      _loginModel = LoginModel.fromJson(value.data);
      print(_loginModel!.data!.token);
      emit(ShopLoginSuccess(_loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginError(error.toString()));
    });
  }

    IconData suffix = Icons.visibility_outlined;
    bool isPassword = true;

    void changePasswordVisibility()
    {
      isPassword = !isPassword;
      suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

      emit(ShopChangePasswordVisibilityState());
    }
  }
