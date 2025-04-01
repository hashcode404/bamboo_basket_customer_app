import 'dart:async';
import 'dart:developer';

import 'package:bamboo_basket_customer_app/application/home/home_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bamboo_basket_customer_app/application/auth/auth_provider.dart';
import 'package:bamboo_basket_customer_app/core/routes/routes.gr.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/core/utils/ui_utils.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/get_provider_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../application/core/dependency_registrar.dart';
import '../../application/products/products_provider.dart';
import '../../core/utils/alert_dialogs.dart';
import '../../core/utils/utils.dart';
import '../../gen/assets.gen.dart';
import '../widgets/button_progress.dart';
import '../widgets/custom_text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    this.isFromProfile = false,
    super.key,
  });

  final bool isFromProfile;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final StreamController<int> _streamController =
      StreamController<int>.broadcast();
  Timer? _timer;
  int _secondsRemaining = 60;

  void startTimer() {
    _timer?.cancel();
    _secondsRemaining = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        _streamController.add(_secondsRemaining);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = notifier(context);
    // final authListener = listener(context);
    final authProvider = context.read<AuthProvider>();
    final authListener = context.watch<AuthProvider>();
    final homeProvider = context.read<HomeProvider>();
    final homeListener = context.watch<HomeProvider>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Assets.images.authBackground.image().image,
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultScreenPadding),
          child: PopScope(
            onPopInvokedWithResult: (_, __) {
              authProvider.clearValues(registerControllersOnly: true);
            },
            child: buildContent(authProvider, context, authListener,
                homeProvider, homeListener),
          ),
        ),
      ),
    );
  }

  Widget buildContent(
      AuthProvider authProvider,
      BuildContext context,
      AuthProvider authListener,
      HomeProvider homeProvider,
      HomeProvider homeListener) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.kWhite.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.kWhite, width: 1.0),
        ),
        child: authListener.selectedAuthView == AuthView.register
            ? _registerFormParent(
                authProvider, context, homeProvider, homeListener, authListener)
            : authListener.selectedAuthView == AuthView.login
                ? _loginForm(authProvider, context, authListener, homeProvider)
                : _forgotWidgetParent(authProvider, context, authListener),
      ),
    );
  }

  Widget _loginForm(
    AuthProvider authProvider,
    BuildContext context,
    AuthProvider authListener,
    HomeProvider homeProvider,
  ) {
    return SingleChildScrollView(
      child: PopScope(
        onPopInvokedWithResult: (_, __) {
          authProvider.clearValues();
        },
        child: SizedBox(
          child: Form(
            key: authProvider.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceLarge,
                SizedBox(
                    width: 180,
                    child: Assets.images.bambooBasketLoginLogo.image()),
                verticalSpaceSmall,
                Text(
                  "Welcome Back !",
                  style: context.customTextTheme.text20W600
                      .copyWith(color: AppColors.kBlack),
                ),
                verticalSpaceSmall,
                Text(
                  "Enter your email and password to log in",
                  style: context.customTextTheme.text12W400,
                ),
                verticalSpaceSmall,
                CustomTextField(
                  controller: authProvider.loginUserNameController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(FluentIcons.mail_24_regular),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                verticalSpaceRegular,
                CustomTextField(
                  controller: authProvider.loginUserPasswordController,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(FluentIcons.password_24_regular),
                  obscureText: authProvider.loginPasswordHide,
                  suffixIcon: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: authProvider.toggleLoginPassword,
                      child: Icon(
                        authListener.loginPasswordHide
                            ? FluentIcons.eye_24_regular
                            : FluentIcons.eye_off_24_regular,
                        color: AppColors.kGray3,
                      )),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.password(),
                  ]),
                ),
                verticalSpaceMedium,
                InkWell(
                  onTap: () {
                    // context.router.push(const ForgotPasswordScreenRoute());
                    authProvider
                        .onChangeSelectedAuthView(AuthView.forgotPassword);
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: context.customTextTheme.text14W700
                        .copyWith(color: AppColors.kBlack),
                  ),
                ),
                verticalSpaceSmall,
                InkWell(
                  onTap: () {
                    final validated = authProvider.validateLoginForm();
                    if (validated) {
                      authProvider.loginUser().then((logged) async {
                        if (logged) {
                          AlertDialogs.showSuccess("Login successfully!");
                          homeProvider.onChangeCurrentPage(0);
                          DependencyRegistrar.initializeAllProviders(context);
                          await Future.delayed(const Duration(seconds: 1), () {
                            // ignore: use_build_context_synchronously
                            context.router.replaceAll([
                              const OrderOnlineScreenRoute(),
                            ]).then((_) {
                              authProvider.clearValues();
                              // productProvider.getAllCategories();
                            });
                          });
                        }
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.kPrimaryColor),
                    height: 50,
                    width: context.screenWidth,
                    child: Center(
                      child: !authListener.loginLoading
                          ? Text(
                              "Log In",
                              style: context.customTextTheme.text16W400
                                  .copyWith(color: AppColors.kWhite),
                            )
                          : showButtonProgress(),
                    ),
                  ),
                ),
                verticalSpaceLarge,
                Visibility(
                  visible: authListener.isRegisterMode == false,
                  child: Row(
                    children: [
                      const Flexible(
                          child: Divider(
                        thickness: 2,
                        color: AppColors.kWhite,
                      )),
                      horizontalSpaceMedium,
                      Text(
                        'Or',
                        style: context.customTextTheme.text12W600
                            .copyWith(color: AppColors.kGray),
                      ),
                      horizontalSpaceMedium,
                      const Flexible(
                          child: Divider(
                        thickness: 2,
                        color: AppColors.kWhite,
                      )),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                RichText(
                  text: TextSpan(
                    style: context.customTextTheme.text14W500
                        .copyWith(color: AppColors.kBlack),
                    children: [
                      const TextSpan(text: "Don't have an account?   "),
                      TextSpan(
                        text: "Sign Up",
                        style: context.customTextTheme.text14W700
                            .copyWith(color: AppColors.kPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            authProvider
                                .onChangeSelectedAuthView(AuthView.register);
                            authProvider.clearValues();
                            // context.router.push(const RegisterScreenRoute());
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerFormParent(
      AuthProvider authProvider,
      BuildContext context,
      HomeProvider homeProvider,
      HomeProvider homeListener,
      AuthProvider authListener) {
    final widgets = [
      _registerForm1(authProvider, context, authListener),
      _registerForm2(authProvider, context, authListener),
      _otpWidget(authProvider, context, authListener),
      _successWidget(authProvider, context, authListener),
    ];
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        authProvider.clearValues(registerControllersOnly: true);
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                visible: authListener.currentRegForm != 3,
                child: IconButton(
                  onPressed: () {
                    if (authListener.currentRegForm == 0) {
                      authListener.onChangeSelectedAuthView(AuthView.login);
                      authProvider.clearValues(registerControllersOnly: true);
                    }
                    if (authListener.currentRegForm == 1) {
                      authProvider.updateCurrentRegForm(0);
                    }
                    if (authListener.currentRegForm == 2) {
                      authProvider.updateCurrentRegForm(1);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceLarge,
                authListener.currentRegForm == 3
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: 170,
                        child: Assets.images.bambooBasketLoginLogo.image()),
                authListener.currentRegForm == 3
                    ? const SizedBox.shrink()
                    : verticalSpaceMedium,
                authListener.currentRegForm == 3
                    ? const SizedBox.shrink()
                    : Text(
                        authListener.currentRegForm == 0 ||
                                authListener.currentRegForm == 1
                            ? "Sign Up !"
                            : authListener.currentRegForm == 2
                                ? "Enter OTP"
                                : '',
                        style: context.customTextTheme.text24W600
                            .copyWith(color: AppColors.kBlack),
                      ),
                verticalSpaceTiny,
                authListener.currentRegForm == 3
                    ? const SizedBox.shrink()
                    : Text(
                        authListener.currentRegForm == 0 ||
                                authListener.currentRegForm == 1
                            ? "Require information to account registrations"
                            : authListener.currentRegForm == 2
                                ? "Enter the OTP send to your registered email"
                                : '',
                        style: context.customTextTheme.text12W400,
                      ),
                verticalSpaceMedium,
                AnimatedCrossFade(
                  firstChild: widgets[authListener.currentRegForm],
                  secondChild: widgets[
                      (authListener.currentRegForm + 1) % widgets.length],
                  duration: const Duration(seconds: 1),
                  firstCurve: Curves.ease,
                  secondCurve: Curves.ease,
                  reverseDuration: const Duration(seconds: 1),
                  sizeCurve: Curves.ease,
                  crossFadeState: CrossFadeState.showFirst,
                ),
                if (authListener.currentRegForm == 2) verticalSpaceSmall,
                verticalSpaceRegular,
                Visibility(
                  visible: authListener.currentRegForm == 2,
                  child: StreamBuilder<int>(
                    stream: _streamController.stream,
                    initialData: _secondsRemaining,
                    builder: (context, snapshot) {
                      if (snapshot.data! > 0) {
                        return Text(
                          "Resend OTP in ${snapshot.data} seconds",
                          style: context.customTextTheme.text14W700
                              .copyWith(color: AppColors.kBlack3),
                        );
                      } else {
                        return TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () async {
                            final result = await authProvider
                                .sendVerifyOTPForRegistration();

                            if (result) {
                              AlertDialogs.showSuccess("OTP sent successfully");
                              startTimer();
                            }
                          },
                          icon: authListener.registerOTPLoading
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.kBlack3)
                              : const SizedBox.shrink(),
                          label: Text(
                            'Resend OTP',
                            style: context.customTextTheme.text14W700
                                .copyWith(color: AppColors.kBlack),
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (authListener.currentRegForm == 2) verticalSpaceSmall,
                InkWell(
                  onTap: () async {
                    bool validated = false;
                    if (authListener.currentRegForm == 0) {
                      validated = authProvider.validateRegisterForm1();
                      if (validated) {
                        authProvider.updateCurrentRegForm(1);
                      }
                    } else if (authListener.currentRegForm == 1) {
                      validated = authProvider.validateRegisterForm2();
                      if (validated) {
                        authProvider.registerOTPController.clear();
                        authProvider
                            .sendVerifyOTPForRegistration()
                            .then((done) {
                          if (done) {
                            authProvider.updateCurrentRegForm(2);
                            startTimer();
                          }
                        });
                      }
                    } else if (authListener.currentRegForm == 2) {
                      bool validated = authProvider.validateRegisterOTP();
                      if (validated) {
                        authProvider.registerUser().then((registered) {
                          if (registered) {
                            AlertDialogs.showSuccess(
                                'Account Created Successfully');
                            authProvider.clearValues();
                            // DependencyRegistrar.initializeAllProviders(context);

                            Future.delayed(const Duration(seconds: 1), () {
                              authProvider.updateCurrentRegForm(3);
                            });
                          } else {
                            AlertDialogs.showError(
                                'Registration failed. Please try again.');
                          }
                        }).catchError((error) {
                          AlertDialogs.showError('An error occurred: $error');
                        });
                      } else {
                        AlertDialogs.showError('Invalid OTP');
                      }
                    } else if (authListener.currentRegForm == 3) {
                      authProvider.updateCurrentRegForm(0);
                      authProvider.onChangeSelectedAuthView(AuthView.login);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.kPrimaryColor),
                    height: 50,
                    width: context.screenWidth,
                    child: Center(
                        child: !authListener.registerOTPLoading
                            ? Text(
                                authListener.currentRegForm == 0
                                    ? "Next"
                                    : authListener.currentRegForm == 1
                                        ? "Register"
                                        : authListener.currentRegForm == 2
                                            ? "Confirm"
                                            : "Go To Login Page",
                                style: context.customTextTheme.text16W400
                                    .copyWith(color: AppColors.kWhite),
                              )
                            : showButtonProgress()),
                  ),
                ),
                verticalSpaceLarge,
                Visibility(
                  visible: authListener.currentRegForm == 0 ||
                      authListener.currentRegForm == 1,
                  child: Row(
                    children: [
                      const Flexible(
                          child: Divider(
                        thickness: 2,
                        color: AppColors.kWhite,
                      )),
                      horizontalSpaceMedium,
                      Text(
                        'Or',
                        style: context.customTextTheme.text12W600
                            .copyWith(color: AppColors.kGray),
                      ),
                      horizontalSpaceMedium,
                      const Flexible(
                          child: Divider(
                        thickness: 2,
                        color: AppColors.kWhite,
                      )),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Visibility(
                  visible: authListener.currentRegForm == 0 ||
                      authListener.currentRegForm == 1,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !authListener.isRegisterMode
                              ? "Already have an account?  "
                              : "Don't have an account?  ",
                          style: context.customTextTheme.text14W500
                              .copyWith(color: AppColors.kBlack),
                        ),
                        TextSpan(
                          text:
                              authListener.isRegisterMode ? "Sign Up" : "Login",
                          style: context.customTextTheme.text14W700
                              .copyWith(color: AppColors.kPrimaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authProvider.updateCurrentRegForm(0);
                              authProvider
                                  .onChangeSelectedAuthView(AuthView.login);
                              // context.router.push(const RegisterScreenRoute());
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpWidget(AuthProvider authProvider, BuildContext context,
      AuthProvider authListener) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, __) =>
          authProvider.registerOTPController.clear(),
      child: PinCodeTextField(
        length: 4,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.0),
          activeColor: AppColors.kBlack,
          inactiveColor: AppColors.kGray,
          inactiveFillColor: AppColors.kOffWhite3,
          activeFillColor: AppColors.kOffWhite3,
          selectedColor: AppColors.kPrimaryColor,
          selectedFillColor: AppColors.kOffWhite3,
          fieldHeight: MediaQuery.of(context).size.width * 0.12,
          fieldWidth: MediaQuery.of(context).size.width * 0.12,
          fieldOuterPadding: const EdgeInsets.all(16.0),
        ),
        controller: authProvider.registerOTPController,
        showCursor: false,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.phone,
        onCompleted: (v) {},
        onChanged: (value) {},
        appContext: context,
        autoDisposeControllers: false,
      ),
    );
  }

  //Widget 4
  Widget _successWidget(AuthProvider authProvider, BuildContext context,
      AuthProvider authListener) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 170, child: Assets.images.success01.image()),
          verticalSpaceSmall,
          authListener.selectedAuthView == AuthView.register
              ? Text('Account Created\nSuccessfully',
                  textAlign: TextAlign.center,
                  style: context.customTextTheme.text24W600
                      .copyWith(color: AppColors.kBlack))
              : Text('Password Reset\nSuccessfully',
                  textAlign: TextAlign.center,
                  style: context.customTextTheme.text24W600
                      .copyWith(color: AppColors.kBlack)),
          verticalSpaceTiny,
          authListener.selectedAuthView == AuthView.register
              ? Text(
                  textAlign: TextAlign.center,
                  'Your Account Created Successfully. Shop Your Favourite Products',
                  style: context.customTextTheme.text14W400
                      .copyWith(color: AppColors.kBlack),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _forgotEmailForm(
      AuthProvider authProvider, AuthProvider authListener) {
    return FormBuilder(
      key: authListener.resetFormKey,
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // key: authListener.emailFieldKey,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(FluentIcons.mail_24_regular),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          hintText: "Email",
        ),
        name: 'email-address',
      ),
    );
  }

  Widget _forgotWidgetParent(AuthProvider authProvider, BuildContext context,
      AuthProvider authListener) {
    final widgets = [
      _forgotEmailForm(authProvider, authListener),
      _forgotNewPasswordForm(authProvider, authListener, context),
      _successWidget(authProvider, context, authListener),

      // _forgotWidget(authProvider, context, authListener),
    ];
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Visibility(
              visible: authListener.currentForgotForm != 2,
              child: IconButton(
                onPressed: () {
                  if (widget.isFromProfile) {
                    Navigator.pop(context);
                  }
                  if (authListener.currentForgotForm == 0) {
                    authProvider.onChangeSelectedAuthView(AuthView.login);
                  }

                  if (authListener.currentForgotForm == 1) {
                    authProvider
                        .onChangeSelectedAuthView(AuthView.forgotPassword);
                    authProvider.updateCurrentForgotForm(
                        (authListener.currentForgotForm - 1) % widgets.length);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(
              //     height: 200,
              //     child: Image(image: AssetImage(Assets.images.loginImage.path))),
              // verticalSpaceSmall,
              authListener.currentForgotForm == 2
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 150,
                      child: Assets.images.bambooBasketTextLogo.image()),
              verticalSpaceMedium,

              authListener.currentForgotForm == 0
                  ? Text('Reset Password',
                      textAlign: TextAlign.center,
                      style: context.customTextTheme.text18W600
                          .copyWith(color: AppColors.kBlack))
                  : const SizedBox.shrink(),
              verticalSpaceMedium,
              AnimatedCrossFade(
                firstChild: widgets[authListener.currentForgotForm],
                secondChild: widgets[
                    (authListener.currentForgotForm + 1) % widgets.length],
                duration: const Duration(seconds: 1),
                firstCurve: Curves.ease,
                secondCurve: Curves.ease,
                reverseDuration: const Duration(seconds: 1),
                sizeCurve: Curves.ease,
                crossFadeState: CrossFadeState.showFirst,
              ),

              verticalSpaceSmall,
              authListener.currentForgotForm == 0
                  ? Text(
                      textAlign: TextAlign.center,
                      'Enter Your Email Address To \nReset Your Password',
                      style: context.customTextTheme.text14W400
                          .copyWith(color: AppColors.kBlack),
                    )
                  : authListener.currentForgotForm == 1
                      ? Text(
                          textAlign: TextAlign.center,
                          'Enter OTP To Reset Your Password',
                          style: context.customTextTheme.text14W400
                              .copyWith(color: AppColors.kBlack),
                        )
                      : const SizedBox.shrink(),
              verticalSpaceSmall,

              InkWell(
                onTap: () async {
                  if (authListener.currentForgotForm == 0) {
                    final isValidated = await authProvider.resetPassword();
                    if (isValidated) {
                      authProvider.resetFormKey.currentState?.save();
                      AlertDialogs.showSuccess('Otp Sent Successfully!');
                      startTimer();
                      authProvider.updateCurrentForgotForm(1);
                    } else {
                      log('INVALIDATED', name: 'isValidated');
                    }
                  } else if (authListener.currentForgotForm == 1) {
                    final isValidated =
                        await authProvider.validateResetPasswordOTP();
                    if (isValidated) {
                      AlertDialogs.showSuccess(
                          "Password Changed successfully!");
                      authProvider.updateCurrentForgotForm(2);
                      return;
                    } else {
                      log('INVALIDATED', name: 'isValidated');
                    }
                  } else if (authListener.currentForgotForm == 2) {
                    authProvider.onChangeSelectedAuthView(AuthView.login);
                    authProvider.updateCurrentForgotForm(0);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kPrimaryColor),
                  height: 50,
                  width: context.screenWidth,
                  child: Center(
                      child: authListener.resetLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2,
                              ))
                          : Text(
                              authListener.currentForgotForm == 0
                                  ? 'Request OTP'
                                  : authListener.currentForgotForm == 1
                                      ? 'Submit'
                                      : 'Go To Login Page',
                              style: context.customTextTheme.text16W400
                                  .copyWith(color: AppColors.kWhite),
                            )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forgotNewPasswordForm(AuthProvider authProvider,
      AuthProvider authListener, BuildContext context) {
    return FormBuilder(
      key: authListener.changePasswordFormKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'OTP',
            validator: FormBuilderValidators.required(
              errorText: 'Required OTP',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.confirmation_number_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: "OTP",
            ),
          ),
          verticalSpaceRegular,
          FormBuilderTextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: authListener.newPasswordFieldKey,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.password(),
            ]),
            // obscureText: authListener.resetPasswordHide,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(FluentIcons.password_24_regular),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: "New Password",
            ),
            name: 'new-password',
          ),
          verticalSpaceRegular,
          FormBuilderTextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.password(),
              FormBuilderValidators.equal(
                authProvider.newPassword,
                checkNullOrEmpty: false,
                errorText: "Passwords do not match",
              ),
            ]),
            obscureText: authListener.resetPasswordHide,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(FluentIcons.password_24_regular),
              suffixIcon: InkWell(
                  onTap: () {
                    authProvider.toggleResetPassword();
                  },
                  child: Icon(authListener.resetPasswordHide
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              hintText: "Confirm Password",
            ),
            name: 'confirm-password',
          ),
          verticalSpaceSmall,
          StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: _secondsRemaining,
            builder: (context, snapshot) {
              if (snapshot.data! > 0) {
                return Text(
                  "Resend OTP in ${snapshot.data} seconds",
                  style: context.customTextTheme.text14W700
                      .copyWith(color: AppColors.kBlack3),
                );
              } else {
                return TextButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () async {
                    final result =
                        await authProvider.resetPassword(isResendOTP: true);

                    if (result) {
                      AlertDialogs.showSuccess("OTP sent successfully");
                    }
                  },
                  icon: authListener.resetLoadingSecondary
                      ? const CupertinoActivityIndicator(
                          color: AppColors.kBlack3)
                      : const SizedBox.shrink(),
                  label: Text(
                    'Resend OTP',
                    style: context.customTextTheme.text14W700
                        .copyWith(color: AppColors.kBlack),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _registerForm1(AuthProvider authProvider, BuildContext context,
      AuthProvider authListener) {
    return Form(
      key: authProvider.registerFormKey1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: authProvider.registerUserFirstNameController,
              hintText: "First Name",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(FluentIcons.person_24_regular),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),

            verticalSpaceRegular,
            // Last Name Field
            CustomTextField(
              controller: authProvider.registerUserLastNameController,
              hintText: "Last Name",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(FluentIcons.person_24_regular),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                // FormBuilderValidators.lastName(),
              ]),
            ),

            verticalSpaceRegular,
            // Mobile Number Field
            CustomTextField(
              controller: authProvider.registerUserPhoneController,
              hintText: "Phone Number",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(FluentIcons.call_24_regular),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.phoneNumber(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerForm2(AuthProvider authProvider, BuildContext context,
      AuthProvider authListener) {
    return Form(
      key: authProvider.registerFormKey2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: authProvider.registerUserEmailController,
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(FluentIcons.mail_24_regular),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),

          verticalSpaceRegular,
          // Last Name Field
          CustomTextField(
            controller: authProvider.registerUserPasswordController,
            hintText: "Password",
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(FluentIcons.password_24_regular),
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            onChanged: (_) => setState(() {}),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.password(),
            ]),
          ),

          verticalSpaceRegular,
          // Mobile Number Field
          CustomTextField(
            controller: authProvider.registerUserConfirmPasswordController,
            hintText: "Confirm Password",
            obscureText: authListener.registerPasswordHide,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            prefixIcon: const Icon(FluentIcons.password_24_regular),
            suffixIcon: InkWell(
                customBorder: const CircleBorder(),
                onTap: authProvider.toggleRegisterPassword,
                child: Icon(
                  authListener.registerPasswordHide
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                  color: AppColors.kGray3,
                )),
            onChanged: (_) => setState(() {}),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.password(),
              FormBuilderValidators.equal(
                authProvider.registerUserPasswordController.text,
                checkNullOrEmpty: false,
                errorText: 'Passwords do not match',
              )
            ]),
          ),
        ],
      ),
    );
  }
}
