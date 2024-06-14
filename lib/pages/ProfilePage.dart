import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;
import 'dart:convert';
import '../Provider/userProvider.dart';
import 'LoginPage.dart';
import '../Api_Connections/Api_Connections.dart';
import 'UpdateProfilePage.dart';
import '../Models/profileModel.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = fetchProfile();
  }

  Future<Profile> fetchProfile() async {
    final profileResponse = await http
        .post(Uri.parse(API.gotoProfileAPI), body: {'user_id': widget.userId});

    if (profileResponse.statusCode == 200) {
      final profileData = jsonDecode(profileResponse.body);
      if (profileData['success']) {
        return Profile.fromJson(profileData['profile']);
      } else {
        throw Exception(profileData['message']);
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }

  void logout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserName(newUserId: '');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.userId.isEmpty) {
      Future.microtask(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ));
      return SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: styles.superColor,
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found'));
          } else {
            final profile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: profile.image != null
                        ? MemoryImage(base64Decode(profile.image!))
                        : null,
                    child: profile.image == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.username,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  _buildProfileItem('Phone Number', profile.phoneNumber),
                  _buildProfileItem('Gender', profile.gender),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProfilePage(
                              userId: widget.userId, profile: profile),
                        ),
                      );
                    },
                    child: const Text('Edit Profile',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: styles.superColor),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: logout,
                    child: const Text('Logout',
                        style: TextStyle(color: Colors.white)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
