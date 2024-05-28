import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocean_talk/bloc/app/app_bloc.dart';
import 'package:ocean_talk/bloc/register/register_bloc.dart';
import 'package:ocean_talk/data/repository/authentication_repository.dart';
import 'package:ocean_talk/data/repository/user_repository.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/screens/app_screen.dart';
import 'package:ocean_talk/presentation/screens/home_screen.dart';
import 'package:ocean_talk/presentation/screens/welcome_screen.dart';
import 'package:ocean_talk/presentation/widget/toast_global_customize.dart';
import 'bloc/friend/friend_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
            create: (context) => AuthenticationRepository(),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppBloc(),),
            BlocProvider(
              create: (context) => RegisterBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
              ),
            ),
            BlocProvider(
                create: (context) => LoginBloc(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                    )),
           BlocProvider(
             create:(context) => FriendBloc(
               userRepository: RepositoryProvider.of<UserRepository>(context),
             ),
           ),
            BlocProvider(
                create: (context) => SearchBloc(
                  userAuthenticationRepository: RepositoryProvider.of<UserRepository>(context),
                )
            )
          ],
          child: ScreenUtilInit(
            builder: (context, child) => ToastGlobalCustomize(
              child:  MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColor.primaryColor,
                    secondary: AppColor.secondaryColor,
                  ),
                  useMaterial3: true,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                home:StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      User? user = snapshot.data;
                      if (user != null) {
                        return const AppScreen();
                      } else {
                        return const WelcomeScreen();
                      }
                    } else {
                      return const Scaffold(body: Center(child: CircularProgressIndicator())); // loading screen
                    }
                  },
                )
              )
            ),
          ),
        ));
  }
}
