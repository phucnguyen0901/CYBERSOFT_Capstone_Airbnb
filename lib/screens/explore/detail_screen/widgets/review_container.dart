import 'package:airbnb_cybersoft/models/comment_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/review_comment_view.dart';
import 'package:airbnb_cybersoft/screens/explore/review_screen/all_reviews_screen.dart';
import 'package:airbnb_cybersoft/screens/explore/review_screen/write_comment_screen.dart';
import 'package:airbnb_cybersoft/services/comment_service.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({super.key, required this.maPhong});
  final int maPhong;

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  List<ModelBinhLuanTheoPhong> comments = [];
  final int maxCount = 10;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    CommentService.getCommentByRoomID(maPhong: widget.maPhong)
        .then((result) {
          setState(() {
            comments = result;
          });
        })
        .catchError((onError) {});
  }

  double _avgStar(List<ModelBinhLuanTheoPhong> comments) {
    double total = 0;
    for (var cmt in comments) {
      total += cmt.saoBinhLuan;
    }
    return total / comments.length;
  }

  @override
  Widget build(BuildContext context) {
    var revComments = comments.reversed.toList();
    return Column(
      children: [
        _header(revComments),
        const SizedBox(height: 16),
        _mainContainer(revComments),
        const SizedBox(height: 16),
        _rateButton(context),
      ],
    );
  }

  GestureDetector _rateButton(BuildContext context) {
    final isLogin = context.watch<AuthProvider>().isLogin;
    return GestureDetector(
      onTap: (!isLogin)
          ? () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please sign in your account to continue!',
                    style: TextStyle(fontWeight: .bold),
                  ),
                ),
              ),
            )
          : () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      WriteCommentScreen(maPhong: widget.maPhong),
                ),
              );
              _fetchData();
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text('Rate this room', style: TextStyle(fontWeight: .bold)),
        ),
      ),
    );
  }

  Widget _mainContainer(List<ModelBinhLuanTheoPhong> revComments) {
    return SizedBox(
      height: 260,
      child: (comments.isEmpty)
          ? const Center(
              child: Text('Empty!', style: TextStyle(color: Colors.grey)),
            )
          : ListView.builder(
              itemCount: (revComments.length > 10) ? 10 : revComments.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var comment = revComments[index];
                return CommentView(comment: comment);
              },
            ),
    );
  }

  Widget _header(List<ModelBinhLuanTheoPhong> revComments) {
    return (revComments.isEmpty)
        ? const Text(
            'This place has no reviews yet!',
            style: TextStyle(fontSize: titleFontSize),
          )
        : Row(
            children: [
              const Icon(Icons.star_rate_rounded, size: titleFontSize),
              const SizedBox(width: 4),
              Text(
                _avgStar(comments).toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: .bold,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                '-',
                style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
              ),
              const SizedBox(width: 16),
              Text(
                '${comments.length.toString()} reviews',
                style: const TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: .bold,
                ),
              ),
              const Expanded(child: SizedBox()),
              if (comments.length > maxCount)
                TextButton(
                  style: TextButton.styleFrom(padding: .zero),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllReviews(comments: revComments),
                      ),
                    );
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: .underline,
                    ),
                  ),
                ),
            ],
          );
  }
}
