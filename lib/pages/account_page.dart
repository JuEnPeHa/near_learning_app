import 'package:flutter/material.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:provider/provider.dart' as Provi;
import 'package:supabase/supabase.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    print("HELOHELOHELOHELOHELO $user ${user.email} ${user.id}");

    final AuthenticationNotifier authNotifier =
        Provi.Provider.of<AuthenticationNotifier>(context);
    List<String> profile = [];
    if (profile == null || profile.isEmpty) {
      authNotifier.getProfile(context: context, userId: user.id).then((value) {
        profile = value ?? [];
        if (profile.length > 0) {
          _usernameController.text = profile[0];
          _firstnameController.text = profile[1];
        }
        print(value.toString() + value.toString() + value.toString());
      });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
              SizedBox(height: 18),
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Name'),
                controller: _usernameController,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                controller: _firstnameController,
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text("Soon more languages"),
                  ),
                  DropdownButton<String>(
                    hint: Text("Choose Language"),
                    items: const [
                      DropdownMenuItem(
                        child: Text("Spanglish"),
                        enabled: true,
                        value: "Spanglish",
                      )
                    ],
                    onChanged: (value) =>
                        ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                          content: Text("Sorry, just spanglish today"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text("OK"),
                              onPressed: () => ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner(),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () async {
                    await authNotifier.updateProfile(
                      userId: user.id,
                      context: context,
                      username: _usernameController.text,
                      firstName: _firstnameController.text,
                      email: user.email ?? "",
                    );
                  },
                  child: Text("Save")),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ]),
      ),
    );
  }
}

// import 'package:supabase/supabase.dart';
// import 'package:near_learning_app/components/auth_required_state.dart';
// import 'package:near_learning_app/components/avatar.dart';
// import 'package:near_learning_app/utils/constants.dart';
// class AccountPage extends StatefulWidget {
//   const AccountPage({Key? key}) : super(key: key);
//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

// class _AccountPageState extends AuthRequiredState<AccountPage> {
//   final _usernameController = TextEditingController();
//   final _websiteController = TextEditingController();
//   String? _userId;
//   String? _avatarUrl;
//   var _loading = false;

//   /// Called once a user id is received within `onAuthenticated()`
//   Future<void> _getProfile(String userId) async {
//     setState(() {
//       _loading = true;
//     });
//     final response = await supabase
//         .from('profiles')
//         .select()
//         .eq('id', userId)
//         .single()
//         .execute();
//     final error = response.error;
//     if (error != null && response.status != 406) {
//       context.showErrorSnackBar(message: error.message);
//     }
//     final data = response.data;
//     if (data != null) {
//       _usernameController.text = (data['username'] ?? '') as String;
//       _websiteController.text = (data['website'] ?? '') as String;
//       _avatarUrl = (data['avatar_url'] ?? '') as String;
//     }
//     setState(() {
//       _loading = false;
//     });
//   }

//   /// Called when user taps `Update` button
//   Future<void> _updateProfile() async {
//     setState(() {
//       _loading = true;
//     });
//     final userName = _usernameController.text;
//     final website = _websiteController.text;
//     final user = supabase.auth.currentUser;
//     final updates = {
//       'id': user!.id,
//       'username': userName,
//       'website': website,
//       'updated_at': DateTime.now().toIso8601String(),
//     };
//     final response = await supabase.from('profiles').upsert(updates).execute();
//     final error = response.error;
//     if (error != null) {
//       context.showErrorSnackBar(message: error.message);
//     } else {
//       context.showSnackBar(
//           message: 'Successfully updated profile!',
//           backgroundColor: Colors.black54);
//     }
//     setState(() {
//       _loading = false;
//     });
//   }

//   Future<void> _signOut() async {
//     final response = await supabase.auth.signOut();
//     final error = response.error;
//     if (error != null) {
//       context.showErrorSnackBar(message: error.message);
//     }
//   }

//   /// Called when image has been uploaded to Supabase storage from within Avatar widget
//   Future<void> _onUpload(String imageUrl) async {
//     final response = await supabase.from('profiles').upsert({
//       'id': _userId,
//       'avatar_url': imageUrl,
//     }).execute();
//     final error = response.error;
//     if (error != null) {
//       context.showErrorSnackBar(message: error.message);
//     }
//     setState(() {
//       _avatarUrl = imageUrl;
//     });
//     context.showSnackBar(message: 'Updated your profile image!');
//   }

//   @override
//   void onAuthenticated(Session session) {
//     final user = session.user;
//     if (user != null) {
//       _userId = user.id;
//       _getProfile(user.id);
//     }
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _websiteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//         children: [
//           Avatar(
//             imageUrl: _avatarUrl,
//             onUpload: _onUpload,
//           ),
//           const SizedBox(height: 18),
//           TextFormField(
//             controller: _usernameController,
//             decoration: const InputDecoration(labelText: 'User Name'),
//           ),
//           const SizedBox(height: 18),
//           TextFormField(
//             controller: _websiteController,
//             decoration: const InputDecoration(labelText: 'Website'),
//           ),
//           const SizedBox(height: 18),
//           ElevatedButton(
//               onPressed: _updateProfile,
//               child: Text(_loading ? 'Saving...' : 'Update')),
//           const SizedBox(height: 18),
//           TextButton(onPressed: _signOut, child: const Text('Sign Out')),
//         ],
//       ),
//     );
//   }
// }
