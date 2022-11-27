import 'package:trisakay/packages.dart';
import 'package:trisakay/main.dart';

class UserModel {
  String? userID;
  String? userFirstName;
  String? userLastName;
  String? userEmail;
  String? userContact;
  String? userAddress;
  RxString? userProfile = ''.obs;
  int? userRole;

  Rxn<VehicleModel?> myVehicle = Rxn<VehicleModel>(null).obs();
  RxList<HistoryModel?> myHistory = RxList<HistoryModel>([]).obs();

  RxString exception = ''.obs;

  UserModel();

  UserModel.getDocumentSnapshot(DocumentSnapshot document) {
    try {
      userID = document.id;
      userFirstName = document.get('user_firstname');
      userLastName = document.get('user_lastname');
      userContact = document.get('user_contact');
      userAddress = document.get('user_address');
      userRole = int.parse(document.get('user_role').toString());
      userProfile?.value = document.get('user_profileurl');
      if (userRole == 2) {
        requestVehicleData();
      }
    } catch (e) {
      throw Exception('no user information');
    }
  }

  UserModel.getQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    try {
      userID = document.id;
      userFirstName = document.get('user_firstname');
      userLastName = document.get('user_lastname');
      userContact = document.get('user_contact');
      userAddress = document.get('user_address');
      userRole = int.parse(document.get('user_role').toString());
      userProfile?.value = document.get('user_profileurl');
      if (userRole == 2) {
        requestVehicleData();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void requestVehicleData() async => myVehicle.value =
      VehicleModel.getDocumentSnapshot(await getVehicleData());

  Future<DocumentSnapshot> getVehicleData() async {
    DocumentSnapshot data =
        await firestore.collection(vehicleCollection).doc(userID).get();

    return data;
  }
}
