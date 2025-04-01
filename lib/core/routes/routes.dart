import 'package:auto_route/auto_route.dart';
import 'package:bamboo_basket_customer_app/core/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashScreenRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(page: WelcomeScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: RegisterScreenRoute.page),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: OtpScreenRoute.page),
        AutoRoute(page: OrderOnlineHomeScreenRoute.page),
        AutoRoute(page: OrderOnlineScreenRoute.page),
        AutoRoute(page: OrderHistoryScreenRoute.page),
        AutoRoute(page: TableReservationScreenRoute.page),
        AutoRoute(page: TableReservationHistoryScreenRoute.page),
        AutoRoute(page: ProfileScreenRoute.page),
        AutoRoute(page: CartScreenRoute.page),
        AutoRoute(page: AddNewAddressScreenRoute.page),
        AutoRoute(page: CheckoutScreenRoute.page),
        AutoRoute(page: CoupenScreenRoute.page),
        AutoRoute(page: ForgotPasswordScreenRoute.page),
        AutoRoute(page: ForgotOtpScreenRoute.page),
        AutoRoute(page: StoreScreenRoute.page),
        AutoRoute(page: SuccessScreenRoute.page),
        AutoRoute(
          page: ViewOrderScreenRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: UserAddressScreenRoute.page,
          fullscreenDialog: true,
        ),
      ];
}
