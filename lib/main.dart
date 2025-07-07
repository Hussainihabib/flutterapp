import 'package:emart_app/firebase_options.dart';
import 'package:emart_app/screens/user/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'consts/consts.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  await Supabase.initialize(
    url: 'https://nedxyaidldyrezsdlpjh.supabase.co',
    anonKey: '<prefer publishable key instead of anon key for mobile and desktop apps>',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme:const  AppBarTheme(

      // to set app bar icon itemdetails
      iconTheme: IconThemeData(
        color: darkFontGrey
      ),
     backgroundColor: Colors.transparent
 ),
    fontFamily: regular,

),
   home: const Splashscreen(),
    );
  }
}
