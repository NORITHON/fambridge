import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      highlightColor: ColorManager.buttonDisable,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.buttonDisable,
      primaryColorDark: ColorManager.primary,
      disabledColor: ColorManager.buttonDisable,
      // ripple color
      splashColor: ColorManager.buttonDisable,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.backgroundColor,
          shadowColor: ColorManager.shadowColor,
          elevation: AppSize.s4),
          
      scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(ColorManager.buttonDisable),
      ),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.shadowColor,
          titleTextStyle: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.buttonDisable,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primary),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.point,
              shadowColor: ColorManager.shadowColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
                  
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorManager.point,
              textStyle: getRegularStyle(color: ColorManager.point),
              )),

      // Text theme
      textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          subtitle1: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          subtitle2: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          caption: getRegularStyle(color: ColorManager.darkGrey),
          bodyText1: getRegularStyle(color: ColorManager.lightGrey)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.lightGrey),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.lightGrey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
