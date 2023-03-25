import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_test_project/presentation/auth/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

int? isLogout= 0;

class SettingsView extends StatefulWidget {
  static const String routeName = 'settingsView';

  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(fontSize: 15.sp),
          ),
          leading: Icon(
            Icons.logout,
            size: 15.sp,
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Logout', style: TextStyle(fontSize: 16.sp),),
                content: Text('Are you sure you want to logout?',  style: TextStyle(fontSize: 13.sp)),
                actions: [
                  TextButton(
                    child: Text('Cancel' ,   style: TextStyle(fontSize: 13.sp, color: Colors.green)),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                      child: Text('Logout',  style: TextStyle(fontSize: 14.sp, color: Colors.red)),
                      onPressed: () {
                        _storeLogoutPageInfo();
                        setState(() {
                          isLogout = 1;
                        });
                        print('Value = $isLogout');
                        Navigator.of(context).pop(true);
                        FirebaseAuth.instance.signOut();

                        //MobileLoginView.isViewed=0;
                        Navigator.pushReplacementNamed(context, LoginView.routeName);
                      }),
                ],
              ),
            );
          },
        ),
      ],
    ));
  }

  _storeLogoutPageInfo() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('logout', isLogout!);
    print(isLogout);
  }
}
