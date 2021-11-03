import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/weather/weather.dart';
import 'package:hydrawise/l10n/l10n.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required GoRouter router,
    required LoginCubit loginCubit,
    required SetAppThemeMode setAppThemeMode,
    required GetAppThemeMode getAppThemeMode,
    required GetCustomerDetails getCustomerDetails,
    required GetCustomerStatus getCustomerStatus,
    required GetApiKey getApiKey,
    required SetApiKey setApiKey,
    required ClearCustomerDetails clearCustomerDetails,
    required RunZone runZone,
    required StopZone stopZone,
    required GetLocation getLocation,
    required SetLocation setLocation,
    required GetWeather getWeather,
  })  : _router = router,
        _loginCubit = loginCubit,
        _setAppThemeMode = setAppThemeMode,
        _getAppThemeMode = getAppThemeMode,
        _getCustomerDetails = getCustomerDetails,
        _getCustomerStatus = getCustomerStatus,
        _getApiKey = getApiKey,
        _setApiKey = setApiKey,
        _clearCustomerDetails = clearCustomerDetails,
        _runZone = runZone,
        _stopZone = stopZone,
        _getLocation = getLocation,
        _setLocation = setLocation,
        _getWeather = getWeather,
        super(key: key);

  final GoRouter _router;
  final LoginCubit _loginCubit;
  final SetAppThemeMode _setAppThemeMode;
  final GetAppThemeMode _getAppThemeMode;
  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final ClearCustomerDetails _clearCustomerDetails;
  final RunZone _runZone;
  final StopZone _stopZone;
  final GetLocation _getLocation;
  final SetLocation _setLocation;
  final GetWeather _getWeather;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<GetCustomerDetails>.value(value: _getCustomerDetails),
          Provider<GetCustomerStatus>.value(value: _getCustomerStatus),
          Provider<GetApiKey>.value(value: _getApiKey),
          Provider<SetApiKey>.value(value: _setApiKey),
          Provider<ClearCustomerDetails>.value(value: _clearCustomerDetails),
          Provider<RunZone>.value(value: _runZone),
          Provider<StopZone>.value(value: _stopZone),
          Provider<GetLocation>.value(value: _getLocation),
          Provider<SetLocation>.value(value: _setLocation),
          Provider<GetWeather>.value(value: _getWeather),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AppCubit(
                setAppThemeMode: _setAppThemeMode,
                getAppThemeMode: _getAppThemeMode,
              ),
            ),
            BlocProvider.value(value: _loginCubit),
            BlocProvider(
              create: (context) => CustomerDetailsCubit(
                getCustomerDetails: _getCustomerDetails,
                getCustomerStatus: _getCustomerStatus,
                loginCubit: context.read<LoginCubit>(),
              )..start(),
            ),
          ],
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.isLoggedIn()) {
                _router.go('/home');
              } else {
                _router.go('/login');
              }
            },
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return MaterialApp.router(
                  theme: _buildLightTheme(context),
                  darkTheme: _buildDarkTheme(context),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                  ],
                  themeMode: state.themeMode,
                  supportedLocales: AppLocalizations.supportedLocales,
                  routeInformationParser: _router.routeInformationParser,
                  routerDelegate: _router.routerDelegate,
                );
              },
            ),
          ),
        ));
  }
}

ThemeData _buildLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    bottomAppBarColor: AppColors.blue700,
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: const IconThemeData(
        color: AppColors.white50,
      ),
      textTheme: _buildDarkTextTheme(base.textTheme),
      color: AppColors.blue700,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.blue700,
      modalBackgroundColor: Colors.white.withOpacity(0.7),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AppColors.blue700,
      selectedIconTheme: const IconThemeData(color: AppColors.orange500),
      selectedLabelTextStyle: GoogleFonts.workSansTextTheme().headline5?.copyWith(
            color: AppColors.orange500,
          ),
      unselectedIconTheme: const IconThemeData(color: AppColors.blue200),
      unselectedLabelTextStyle: GoogleFonts.workSansTextTheme().headline5?.copyWith(
            color: AppColors.blue200,
          ),
    ),
    chipTheme: _buildChipTheme(
      AppColors.blue700,
      AppColors.lightChipBackground,
      Brightness.light,
    ),
    canvasColor: AppColors.white50,
    cardColor: AppColors.white50,
    colorScheme: _lightColorScheme,
    textTheme: _buildLightTextTheme(base.textTheme),
    scaffoldBackgroundColor: AppColors.blue50,
  );
}

ThemeData _buildDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  final darkTextTheme = _buildDarkTextTheme(base.textTheme);
  return base.copyWith(
    bottomAppBarColor: AppColors.darkBottomAppBarBackground,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkDrawerBackground,
      modalBackgroundColor: Colors.black.withOpacity(0.7),
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: const IconThemeData(
        color: AppColors.white50,
      ),
      textTheme: darkTextTheme,
      color: AppColors.darkBottomAppBarBackground,
      elevation: 0,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AppColors.darkBottomAppBarBackground,
      selectedIconTheme: const IconThemeData(color: AppColors.orange300),
      selectedLabelTextStyle: GoogleFonts.workSansTextTheme().headline5?.copyWith(
            color: AppColors.orange300,
          ),
      unselectedIconTheme: const IconThemeData(color: AppColors.greyLabel),
      unselectedLabelTextStyle: GoogleFonts.workSansTextTheme().headline5?.copyWith(
            color: AppColors.greyLabel,
          ),
    ),
    chipTheme: _buildChipTheme(
      AppColors.blue200,
      AppColors.darkChipBackground,
      Brightness.dark,
    ),
    canvasColor: AppColors.black900,
    cardColor: AppColors.darkCardBackground,
    colorScheme: _darkColorScheme,
    textTheme: darkTextTheme,
    scaffoldBackgroundColor: AppColors.black900,
  );
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    button: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: AppColors.black900,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.1,
      color: AppColors.black900,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.4,
      color: AppColors.black900,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.5,
      color: AppColors.black900,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: AppColors.black900,
    ),
  );
}

TextTheme _buildDarkTextTheme(TextTheme base) {
  return base.copyWith(
    button: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: AppColors.white50,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.1,
      color: AppColors.white50,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.4,
      color: AppColors.white50,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.5,
      color: AppColors.white50,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: AppColors.white50,
    ),
  );
}

ChipThemeData _buildChipTheme(
  Color primaryColor,
  Color chipBackground,
  Brightness brightness,
) {
  return ChipThemeData(
    backgroundColor: primaryColor.withOpacity(0.12),
    disabledColor: primaryColor.withOpacity(0.87),
    selectedColor: primaryColor.withOpacity(0.05),
    secondarySelectedColor: chipBackground,
    padding: const EdgeInsets.all(4),
    shape: const StadiumBorder(),
    labelStyle: GoogleFonts.workSansTextTheme().bodyText2!.copyWith(
          color: brightness == Brightness.dark ? AppColors.white50 : AppColors.black900,
        ),
    secondaryLabelStyle: GoogleFonts.workSansTextTheme().bodyText2!,
    brightness: brightness,
  );
}

const ColorScheme _lightColorScheme = ColorScheme.light(
  primary: AppColors.blue700,
  primaryVariant: AppColors.blue800,
  secondary: AppColors.orange500,
  secondaryVariant: AppColors.orange400,
  surface: AppColors.white50,
  error: AppColors.red400,
  onPrimary: AppColors.white50,
  onSecondary: AppColors.black900,
  onBackground: AppColors.black900,
  onSurface: AppColors.black900,
  onError: AppColors.black900,
  background: AppColors.blue50,
);

const ColorScheme _darkColorScheme = ColorScheme.dark(
  primary: AppColors.blue200,
  primaryVariant: AppColors.blue300,
  secondary: AppColors.orange300,
  secondaryVariant: AppColors.orange300,
  surface: AppColors.black800,
  error: AppColors.red200,
  onPrimary: AppColors.black900,
  onSecondary: AppColors.black900,
  onBackground: AppColors.white50,
  onSurface: AppColors.white50,
  onError: AppColors.black900,
  background: AppColors.black900Alpha087,
);
