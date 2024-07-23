import '../models/profile.dart';
import 'firestore_service.dart';

class PropertyService {
  final FirestoreService firestoreService;

  PropertyService(this.firestoreService);

  Future<void> fetchPropertyData(String userId) async {
    Profile userProfile = await firestoreService.fetchUserProfile(userId);
    // Fetch property data only for the user's assigned property
    await firestoreService.fetchPropertyData(userProfile.propertyId);
  }
}
