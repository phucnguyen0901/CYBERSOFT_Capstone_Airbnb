import 'package:airbnb_cybersoft/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key, required this.comment});

  final ModelBinhLuanTheoPhong comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(comment.avatar),
                  onBackgroundImageError: (exception, stackTrace) =>
                      Icon(Icons.image_not_supported),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        comment.tenNguoiBinhLuan,
                        style: TextStyle(fontWeight: .bold),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        parseCmtDay(comment.ngayBinhLuan),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      double.parse(comment.saoBinhLuan.toString())
                          .toStringAsFixed(1),
                    ),
                    const Icon(Icons.star_rate_rounded, color: Colors.amber),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Text(comment.noiDung, overflow: .fade),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseCmtDay(String dtString) {
    try {
      int d = DateTime.parse(dtString).day;
      int m = DateTime.parse(dtString).month;
      int y = DateTime.parse(dtString).year;
      return '$d-$m-$y';
    } catch (err) {
      return '';
    }
  }
}
