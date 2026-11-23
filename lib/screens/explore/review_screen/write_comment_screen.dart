import 'package:airbnb_cybersoft/models/comment_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/services/comment_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteCommentScreen extends StatefulWidget {
  const WriteCommentScreen({super.key, required this.maPhong});
  final int maPhong;

  @override
  State<WriteCommentScreen> createState() => _WriteCommentScreenState();
}

class _WriteCommentScreenState extends State<WriteCommentScreen> {
  final _cmtController = TextEditingController();
  final DateTime ngayBinhLuan = DateTime.now();
  String token = '';
  int saoBinhLuan = 5;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _post(int maNguoiBinhLuan, String noiDung) async {
    final token = context.read<AuthProvider>().accessToken;
    var comment = BinhLuanViewModel(
      id: 0,
      maPhong: widget.maPhong,
      maNguoiBinhLuan: maNguoiBinhLuan,
      ngayBinhLuan: ngayBinhLuan.toString(),
      noiDung: noiDung,
      saoBinhLuan: saoBinhLuan,
    );
    await CommentService.postComment(accessToken: token, comment: comment);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: _appBar(context, user.id!),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Row(
                crossAxisAlignment: .center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.avatar!),
                    onBackgroundImageError: (exception, stackTrace) =>
                        Icon(Icons.image_not_supported),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(fontWeight: .bold),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: .center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          saoBinhLuan = index + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star_rate_rounded,
                        color: (index <= saoBinhLuan - 1)
                            ? Colors.amber
                            : Colors.grey,
                        size: 30,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cmtController,
                scrollController: ScrollController(),
                maxLines: 10,
                maxLength: 300,
                decoration: InputDecoration(
                  border: .none,
                  hintText: 'Leave your comment here...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, int maNguoiDung) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                decoration: .underline,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _post(maNguoiDung, _cmtController.text.trim());
              if (!context.mounted) return;
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Review posted successfully!',
                      style: TextStyle(fontWeight: .bold),
                    ),
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text(
              'Post',
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                decoration: .underline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
