import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management_app/controller/provider.dart';
import 'package:provider_student_management_app/firebase_options.dart';
import 'package:provider_student_management_app/presentation/home/screen_home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp( const MyApp() );
}

class MyApp extends StatelessWidget { 
  
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
       ChangeNotifierProvider(create:(context) => StudetsDetailProvider(),)
    ],
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith( 
        primaryColor: Colors.amber,  
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white, 
        ),  
      ),
      home:  ScreenHome(),
    ),
    );
  }
}
