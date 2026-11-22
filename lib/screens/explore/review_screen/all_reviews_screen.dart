import 'package:airbnb_cybersoft/models/comment_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/review_comment_view.dart';
import 'package:flutter/material.dart';

class AllReviews extends StatelessWidget {
  const AllReviews({super.key, required this.comments});
  final List<ModelBinhLuanTheoPhong> comments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: BackButton(),
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text('${comments.length} reviews'),
            const Text(
              'Sorted by newest',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        padding: EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: CommentView(comment: comment),
            ),
          );
        },
      ),
    );
  }
}
