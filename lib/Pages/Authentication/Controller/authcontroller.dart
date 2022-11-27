import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';
import 'package:location/location.dart' as loc;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AuthController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController plateNumber = TextEditingController();
  final TextEditingController imageURL = TextEditingController();

  RxBool passenger = true.obs;

  RxBool isSignup = false.obs;

  Rxn<CameraPosition>? mylocation = Rxn<CameraPosition>(null).obs();
  loc.Location location = loc.Location();

  final ImagePicker _picker = ImagePicker();
  Rxn<File>? photoFile = Rxn<File>(null).obs();
  Rxn<XFile>? photoXFile = Rxn<XFile>(null).obs();

  FirebaseStorage storageReference = FirebaseStorage.instance;

  UserModel user = UserModel();

  //Exception Responce
  final String weekPasswordException = 'The password provided is too weak.';
  final String emailAlreadyExistException =
      'The account already exists for that email.';
  final String emailInvalidException = "Email is invalid";

  RxString siginHeader = 'Login'.obs;
  RxBool onSubmit = false.obs;
  Rxn<Color> loginColor = Rxn<Color>(Colors.deepPurple).obs();

  RxBool onLogin = true.obs;
  RxString exception = ''.obs;
  RxString authException = ''.obs;

  RxBool updateAccountStatus = false.obs;
  RxString updateAccountStatusMessage = ''.obs;

  RxBool onInitialize = true.obs;

  ControllerHandlerClass? controllerHandlerClass;

  List<String> userRole = ['Passenger', 'Rider'];
  RxString userRoleSelected = ''.obs;

  RxBool show2ndForm = false.obs;

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((user) async {
      if (user == null && onInitialize.value) {
        navigateToLogin();
        return;
      }
      if (isSignup.isFalse) {
        bool result = await requestUserData();
      }
      onInitialize.value = false;
    }, onError: (err) => exception.value = err.toString(), cancelOnError: true);
  }

  void initializedTextControllers() {
    try {
      firstname.text = user.userFirstName!;
      lastname.text = user.userLastName!;
      contact.text = user.userContact!;
      address.text = user.userAddress!;
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void navigateToLogin() => Get.toNamed('/login');
  void navigateToRegistration() => Get.toNamed('/register');
  void navigateToUserInformation() => Get.toNamed('/userinfo');
  void navigateToHome() => Get.toNamed('/home');

  void signin() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('user-not-found')) {
        authException.value = 'No user found for that email.';
      } else if (e.code.contains('wrong-password')) {
        authException.value = 'Wrong password.';
      } else if (e.code.contains('too-many-requests')) {
        authException.value = 'Your account has temporary blocked';
      }

      authException.refresh();
    }
  }

  void closeErrorContainer() => authException.value = '';

  void updateSigninButtonState() => {updateSubmitStatus(), updateSignTitle()};

  void updateSubmitStatus() => onSubmit.toggle();

  void updateSignTitle() =>
      siginHeader.value = onSubmit.isTrue ? 'Signing in' : 'Login';

  Future<bool> signup() async {
    try {
      isSignup.value = true;
      await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      navigateToUserInformation();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        authException.value = emailInvalidException;
      } else if (e.code == 'weak-password') {
        authException.value = weekPasswordException;
      } else if (e.code == 'email-already-in-use') {
        authException.value = emailAlreadyExistException;
      }
      authException.refresh();
    } catch (e) {
      authException.value = e.toString();
    }
    return false;
  }

  void signout() {
    try {
      auth.signOut();
      navigateToLogin();
      controllerHandlerClass!.destroyControllers();
    } catch (e) {
      authException.value = e.toString();
    }
  }

  void requestEmailVerification() => sendEmailVerifaction();

  Future<bool> sendEmailVerifaction() async {
    try {
      await auth.sendPasswordResetEmail(email: user.userEmail!);

      updateAccountStatusMessage.value = 'Please check your email.';
      return true;
    } catch (e) {
      exception.value = e.toString();
    }
    return false;
  }

  Future<bool> requestUserData() async {
    try {
      DocumentSnapshot docs = await firestore
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();

      user = UserModel.getDocumentSnapshot(docs);

      controllerHandlerClass = ControllerHandlerClass(true);
      cleanTextControllers();
      Future.delayed(const Duration(milliseconds: 500), () => navigateToHome());
      isSignup.value = false;
      return true;
    } catch (e) {
      navigateToUserInformation();
    }
    return false;
  }

  void cleanTextControllers() {
    email.clear();
    password.clear();
    firstname.clear();
    lastname.clear();
    confirmPassword.clear();
    onSubmit.value = false;
    siginHeader.value = 'Login';
  }

  Future<bool> postUserData() async {
    try {
      RxString url = ''.obs;
      if (photoFile?.value != null) {
        Reference ref = storageReference.ref('profiles/');
        ref.putFile(photoFile!.value!);
        url.value = await ref.getDownloadURL();
      }

      await firestore
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .set({
        "user_firstname": firstname.text,
        "user_lastname": lastname.text,
        "user_contact": contact.text,
        "user_address": address.text,
        "user_role": userRoleSelected.value == 'Passenger' ? 1 : 2,
        "user_profileurl": url.value == '' ? 'NONE' : url.value,
      });

      if (userRoleSelected.value != 'Passenger') {
        registerVehicle();
      }

      requestUserData();
      return true;
    } catch (e) {
      exception.value = e.toString();
    }

    return false;
  }

  void registerVehicle() async {
    try {
      LatLng? location = await currentLocation();
      if (location != null) {
        await firestore
            .collection(vehicleCollection)
            .doc(auth.currentUser!.uid)
            .set({
          "vehicle_plateNo": plateNumber.text,
          "vehicle_location": convertLatLng(location)
        });
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  Future<bool> putUserData() async {
    try {
      RxString url = ''.obs;
      if (photoFile?.value != null) {
        Reference ref = storageReference.ref('profiles/');
        ref.putFile(photoFile!.value!);
        url.value = await ref.getDownloadURL();
      }

      await firestore.collection(userCollection).doc(user.userID).update({
        "user_firstname": firstname.text,
        "user_lastname": lastname.text,
        "user_address": address.text,
        "user_contact": contact.text,
      });

      updateAccountStatusMessage.value = 'Account Updated';
      return true;
    } catch (e) {
      exception.value = e.toString();
    }
    return false;
  }

  Future<bool> changePassword() async {
    try {
      auth.currentUser!.updatePassword(password.text);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.toString().toLowerCase().contains('weak-password')) {
        exception.value = 'Weak Password';
      }
      exception.value = e.toString();
    } catch (e) {
      exception.value = e.toString();
    }

    return false;
  }

  void initializePhoto() async {
    photoXFile?.value = await _picker.pickImage(source: ImageSource.camera);
    photoFile?.value = File(photoXFile!.value!.path);
  }

  void initializeGalery() async {
    photoXFile?.value = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 150, maxHeight: 150);
    photoFile?.value = File(photoXFile!.value!.path);
  }

  void updateProfileCamera() async {
    try {
      photoXFile?.value = await _picker.pickImage(source: ImageSource.camera);
      photoFile?.value = File(photoXFile!.value!.path);

      RxString url = ''.obs;
      if (photoFile?.value != null) {
        Reference ref = storageReference.ref('profiles/');
        ref.putFile(photoFile!.value!);
        url.value = await ref.getDownloadURL();

        firestore.collection(userCollection).doc(auth.currentUser!.uid).update({
          "user_profileurl": url.value == '' ? 'NONE' : url.value,
        });

        user.userProfile?.value = url.value;
        user.userProfile?.refresh();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void updateProfileGalery() async {
    try {
      photoXFile?.value = await _picker.pickImage(source: ImageSource.gallery);
      photoFile?.value = File(photoXFile!.value!.path);

      RxString url = ''.obs;
      if (photoFile?.value != null) {
        Reference ref = storageReference.ref('profiles/');
        ref.putFile(photoFile!.value!);
        url.value = await ref.getDownloadURL();

        firestore.collection(userCollection).doc(auth.currentUser!.uid).update({
          "user_profileurl": url.value == '' ? 'NONE' : url.value,
        });

        user.userProfile?.value = url.value;
        user.userProfile?.refresh();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
