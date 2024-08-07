import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/business_logic/models/profile.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch property data based on user's propertyId
  Future<Map<String, dynamic>> fetchPropertyData(String propertyId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('properties').doc(propertyId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Property not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch property data: $e');
    }
  }

  Future<QuerySnapshot> fetchLatestDrench(String userId, String mobId) async {
    return await _firestore
        .collection('users')
        .doc(userId)
        .collection('mobs')
        .doc(mobId)
        .collection('drenches')
        .orderBy('date', descending: true)
        .limit(1)
        .get();
  }

  Future<void> saveEggResults(String mobNumberString, int eggCountResults) async {
    try {
      int mobNumber = int.parse(mobNumberString);

      String userId = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference mobsCollection =
          _firestore.collection('users').doc(userId).collection('mobs');

      QuerySnapshot querySnapshot =
          await mobsCollection.where('mobNumber', isEqualTo: mobNumber).get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No mob found with the given mob number');
      }

      DocumentReference mobDocRef = querySnapshot.docs.first.reference;
      // Reference to the 'eggResults' subcollection under the mob document
      CollectionReference eggResultsCollection =
          mobDocRef.collection('eggResults');

      // Save egg count results to the 'eggResults' subcollection
      await eggResultsCollection.add({
        'eggCount': eggCountResults,
        'dateRecorded': Timestamp.now(),
      });

      // Success message or feedback
      print('Egg results added successfully');
    } catch (e) {
      print('Error adding egg results: $e');
      throw Exception('Failed to add egg results: $e');
    }
  }

  // method that fetches all mobs, not just the mobs of current user
  // not to be confused to fetchUserMobs
  Future<List<String>> fetchMobs(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('mobs')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc['mobNumber'].toString()).toList();
    } catch (e) {
      print('Error fetching mobs: $e');
      return [];
    }
  }

  Future<void> savePropertyData(
      String userEmail,
      String propertyName,
      String location,
      String country,
      String countryCode,
      String postalCode,
      DateTime createdAt) async {
    await _firestore.collection('properties').add({
      'userEmail': userEmail,
      'propertyName': propertyName,
      'location': location,
      'country': country,
      'countryCode': countryCode,
      'postalCode': postalCode,
      'createdAt': createdAt,
    });
  }

  Future<void> saveMob(String propertyAddress, int paddockId, int mobNumber,
      String mobName, String userId, String userEmail) async {
    final mobData = {
      'propertyAddress': propertyAddress,
      'paddockId': paddockId,
      'mobNumber': mobNumber,
      'mobName': mobName,
      'userId': userId,
      'userEmail': userEmail,
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('mobs')
          .add(mobData);
      print('Mob data saved successfully: $mobData');
    } catch (e) {
      print('Failed to save mob data: $e');
      // Handle the error appropriately, e.g., show a message to the user
    }
  }

  Future<String?> fetchUserPropertyAddress() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String userEmail = currentUser.email!;
        QuerySnapshot propertySnapshot = await _firestore
            .collection('properties')
            .where('userEmail', isEqualTo: userEmail)
            .get();
        if (propertySnapshot.docs.isNotEmpty) {
          return propertySnapshot.docs.first['location'];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching property address: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserMobs() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case where the user is not logged in
      print('User not logged in');
      return [];
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('mobs')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        // Ensure mobNumber is always a string
        data['mobNumber'] = data['mobNumber'].toString();
        return data;
      }).toList();

    } catch (e) {
      print('Error fetching mobs: $e');
      return [];
    }
  }

  Future<int> fetchFecalEggCount(String userId, String mobId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('mobs')
        .doc(mobId)
        .collection('eggResults')
        .orderBy('dateRecorded', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['eggCount'];
    } else {
      print("No egg results are found. FirestoreService fetchFecalEggCount method.");
      return 0;
    }
  }

  Future<void> saveUserProfile(Profile userProfile) async {
    await _firestore.collection('users')
        .doc(userProfile.userId)
        .set(userProfile.toMap());
  }


  Future<Profile> fetchUserProfile(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();

    if (!doc.exists) {
      throw Exception('Profile not found');
    }

    // Ensure data exists and is of the expected type
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('No data found for this profile');
    }

    try {
      return Profile.fromMap(data);
    } catch (e) {
      throw Exception('Failed to parse profile data: $e');
    }
  }

}
