import 'package:flutter/services.dart';
import 'package:trisakay/packages.dart';
import 'package:trisakay/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/* Name of application */
String appName = 'Trisakay';

AuthController? authController;

/*
  * [Firebase Packages]
  * Initialize firebase packages global for reuse in every packages needed.
*/
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

/*
  * [Collection]
  * Initialize firestore collection names for reuse in every packages needed;
 */
const String userCollection = "User_Collection";
const String riderCollection = "Rider_Collection";
const String vehicleCollection = "Vehicle_Collection";
const String bookingCollection = "Booking_Collection";
const String transactionCollection = "Transaction_Collection";
const String ratingsCollection = "Ratings_Collection";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Loader(),
      initialBinding: BindControllers(),
      getPages: [
        GetPage(name: '/', page: () => const Loader()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/home', page: () => const HomeView()),
        GetPage(name: '/register', page: () => const RegisterView()),
        GetPage(name: '/userinfo', page: () => const UserInformation()),
        GetPage(name: '/newdestination', page: () => const NewDestination()),
        GetPage(name: '/createmarker', page: () => const CreateMarkerView()),
        GetPage(name: '/menu', page: () => const MenuView()),
        GetPage(name: '/account', page: () => const AccountView()),
        GetPage(name: '/history', page: () => const HistoryView()),
        GetPage(name: '/report', page: () => const CreateReport()),
        GetPage(name: '/about', page: () => const AboutView()),
        GetPage(name: '/cancel', page: () => const BookingCancel()),
        GetPage(name: '/searchbook', page: () => const AvailableBook()),
        GetPage(name: '/rate', page: () => const RateRider()),
        GetPage(name: '/forgot', page: () => const ForgotView()),
      ],
    );
  }
}
