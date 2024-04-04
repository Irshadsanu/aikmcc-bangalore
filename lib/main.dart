import 'package:aikmccbangalore/Excel.dart';
import 'package:aikmccbangalore/Provider/LoginProvider.dart';
import 'package:aikmccbangalore/Screens/User/HomeScreen.dart';
import 'package:aikmccbangalore/Screens/User/consentScreen.dart';
import 'package:aikmccbangalore/Screens/admin/Add_Cordinator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'Provider/UserProvider.dart';
import 'Provider/mainprovider.dart';
import 'Screens/Splash Screen.dart';
import 'Screens/User/RegistrationSuccessPage.dart';
import 'Screens/User/myRegistrationPage.dart';
import 'Screens/User/registration_screen.dart';
import 'Screens/admin/AdminHomeScreen.dart';
import 'Screens/admin/LoginScreen.dart';
import 'Screens/admin/approveScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb){
    await Firebase.initializeApp();

  }else{
    await Firebase.initializeApp(
        options:const FirebaseOptions(
            apiKey: "AIzaSyC88hsNKtYmdLOZuzjsnCZL7Bl60VaD4I8",
            authDomain: "aikmcc.firebaseapp.com",
            databaseURL: "https://aikmcc-default-rtdb.firebaseio.com",
            projectId: "aikmcc",
            storageBucket: "aikmcc.appspot.com",
            messagingSenderId: "849965306415",
            appId: "1:849965306415:web:e24ecbc13575e96967acda",
            measurementId: "G-1DGRPKZVX7"
        )
    );
  }
  runApp( const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'AIKMCC BENGALURU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
         home: SplashScreen(),
         // home: RegistrationScreen(),
         // home:  Download(),
         //  home: ConsentScreen(),
        // home: AddCordinatorScreen(),
      ),
    );
  }
}
