import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({super.key});

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  final int maxCount = 5;
  int itemCount = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        const SizedBox(height: 16),
        _mainContainer(),
        const SizedBox(height: 16),
        _rateButton(),
      ],
    );
  }

  GestureDetector _rateButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text('Rate this room', style: TextStyle(fontWeight: .bold)),
        ),
      ),
    );
  }

  Widget _mainContainer() {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
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
                      CircleAvatar(radius: 25, backgroundColor: Colors.grey),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Tên người bình luận',
                              style: TextStyle(fontWeight: .bold),
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'số ngày đã qua',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text('3'),
                          const Icon(Icons.star_rate_rounded),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(sampleText, overflow: .fade),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row _header() {
    return Row(
      children: [
        const Icon(Icons.star_rate_rounded, size: titleFontSize),
        const SizedBox(width: 4),
        const Text(
          '5.0',
          style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
        ),
        const SizedBox(width: 16),
        const Text(
          '-',
          style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
        ),
        const SizedBox(width: 16),
        const Text(
          '3 reviews',
          style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
        ),
        const Expanded(child: SizedBox()),
        if (itemCount > maxCount)
          TextButton(
            style: TextButton.styleFrom(padding: .zero),
            onPressed: () {},
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.black, decoration: .underline),
            ),
          ),
      ],
    );
  }
}

final sampleText =
    'The standard Lorem Ipsum passage, used since the 1500s\n\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"\n\nSection 1.10.32 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC\n\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?\"\n\n1914 translation by H. Rackham\n\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?\"\n\nSection 1.10.33 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC\n\"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et';
