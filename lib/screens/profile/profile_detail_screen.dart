import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/services/user_service.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  ThongTinNguoiDung? user;
  String dateTime = '';
  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await UserService.getUserInfoByID(userProvider.user.id!)
        .then((result) {
          setState(() {
            user = result.user;
            dateTime = DateTime.parse(result.dateTime).year.toString();
          });
        })
        .catchError((onError) {});
  }

  void _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await clearStorage();
    authProvider.setLogout();
    userProvider.clearUser();
    debugPrint('loged out');
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? Center()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: _appBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      _heading(user!),
                      const DividerWidget(),
                      normalSvgIcon(
                        assetName:
                            'assets/icons/detail_room_icon/Verification.svg',
                        color: const Color.fromARGB(255, 12, 101, 15),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Identity verification',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: .bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Show others you\'re really you with the \nidentity verification badge',
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text('Get the badge'),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          const Icon(Icons.translate),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: const Text(
                                  'Some info is shown in it\'s original language.',
                                  maxLines: 2,
                                ),
                              ),

                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Translate',
                                  style: TextStyle(decoration: .underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Matt confirmed',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: .bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      (user!.phone == 'string')
                          ? const Text(
                              'No matt confirmed',
                              style: TextStyle(color: Colors.grey),
                            )
                          : const Row(
                              children: [
                                Icon(Icons.done),
                                SizedBox(width: 16),
                                Text('Phone number'),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Column _heading(ThongTinNguoiDung user) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        CircleAvatar(
          radius: 65,
          backgroundImage: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzkYfwmc1UjcLkt-4kUv7_Gd_vA3ayx6-33dej-XXyw&s=10',
          ),
          onBackgroundImageError: (exception, stackTrace) =>
              Container(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(fontSize: headerFontSized, fontWeight: .bold),
        ),
        const SizedBox(height: 8),
        Text('Joined in $dateTime'),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: BackButton(),
      actions: [
        TextButton(
          onPressed: () {
            _showEditBottomSheet(context);
          },
          child: const Text(
            'Edit',
            style: TextStyle(decoration: .underline, color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            _logout();
            Navigator.of(context).pop();
          },
          child: const Text(
            'Log out',
            style: TextStyle(decoration: .underline, color: Colors.black),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 8),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Edit profile',
                        style: TextStyle(fontWeight: .bold),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        decoration: .underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircleAvatar(backgroundColor: Colors.grey, radius: 80),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('About me'),
                trailing: TextButton(onPressed: () {}, child: Text('Add')),
              ),
              const Divider(),
              ListTile(
                title: Text('About me'),
                trailing: TextButton(onPressed: () {}, child: Text('Add')),
              ),
              const Divider(),
              ListTile(
                title: Text('About me'),
                trailing: TextButton(onPressed: () {}, child: Text('Add')),
              ),
              const Divider(),
              ListTile(
                title: Text('About me'),
                trailing: TextButton(onPressed: () {}, child: Text('Add')),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
