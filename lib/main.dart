import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_talk/bloc/register/register_bloc.dart';
import 'package:ocean_talk/data/repository/authentication_repository.dart';
import 'package:ocean_talk/data/repository/user_repository.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/screens/login_screen.dart';
import 'package:ocean_talk/presentation/screens/welcome_screen.dart';
import 'package:ocean_talk/presentation/widget/toast_global_customize.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers:[
          RepositoryProvider<AuthenticationRepository>(
            create: (context) => AuthenticationRepository(),
          ),
          RepositoryProvider<UserRepository>(create: (context) => UserRepository(),
          )
        ] , child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => ToastGlobalCustomize(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColor.primaryColor,
                secondary: AppColor.secondaryColor,
              ),
              useMaterial3: true,
              fontFamily: GoogleFonts.poppins().fontFamily,
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme,),
            ),
            routes: {
              "/": (context) => const WelcomeScreen(), // This is the default route
              "/login": (context) => const LoginScreen(),
            },
          ),
        ),
      ),
    )
    );
  }
}
