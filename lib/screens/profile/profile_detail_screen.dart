import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _heading(),
                const DividerWidget(),
                normalSvgIcon(
                  assetName: 'assets/icons/detail_room_icon/Verification.svg',
                  color: const Color.fromARGB(255, 12, 101, 15),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Identity verification',
                  style: TextStyle(fontSize: 24, fontWeight: .bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Show others you\'re really you with the \nidentity verification badge',
                  style: TextStyle(fontSize: 16),
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
                Divider(),

                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Icon(Icons.translate),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Some info is shown in it\'s original language.',
                            style: TextStyle(fontSize: 14),
                            maxLines: 2,
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Text(
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
                  style: TextStyle(fontSize: 32, fontWeight: .bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.done),
                    const SizedBox(width: 16),
                    const Text('Phone number', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _heading() {
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
        const Text(
          'Hi, I\'m Dolly',
          style: TextStyle(fontSize: 32, fontWeight: .bold),
        ),
        const SizedBox(height: 8),
        const Text('Joined in 2021', style: TextStyle(fontSize: 16)),
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
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  ),
                  Expanded(
                    child: Center(
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(fontWeight: .bold),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
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
