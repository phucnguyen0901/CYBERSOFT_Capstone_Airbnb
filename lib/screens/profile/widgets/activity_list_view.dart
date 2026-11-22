import 'package:airbnb_cybersoft/providers/activity_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/explore/screens/detail_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityListView extends StatefulWidget {
  const ActivityListView({super.key});

  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    final maNguoiDung = userProvider.user.id!;
    final activityProvider = context.read<ActivityProvider>();
    activityProvider.getActivities(maNguoiDung);
  }

  String dateTime(String dtString) {
    int y = DateTime.parse(dtString).year;
    int m = DateTime.parse(dtString).month;
    int d = DateTime.parse(dtString).day;
    return '$d-$m-$y';
  }

  @override
  Widget build(BuildContext context) {
    final activities = context.watch<ActivityProvider>().activities;
    final rooms = context.watch<ActivityProvider>().rooms;

    return (rooms.isEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
            child: Center(
              child: const Text(
                'No activities yet!',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            itemCount: activities.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              var reserveInfo = activities[index];
              var room = rooms[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(room: room),
                  ),
                ),
                child: SizedBox(
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(24),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            room.hinhAnh,
                            fit: .cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          Expanded(
                            child: Text(
                              room.tenPhong,
                              style: const TextStyle(fontWeight: .bold),
                              maxLines: 2,
                              overflow: .ellipsis,
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'From ${dateTime(reserveInfo.ngayDen)} to ${dateTime(reserveInfo.ngayDi)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.people_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${reserveInfo.soLuongKhach.toString()} guest(s)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            size: 20,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${room.giaTien}\$ per. night',
                            style: const TextStyle(
                              fontWeight: .bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
