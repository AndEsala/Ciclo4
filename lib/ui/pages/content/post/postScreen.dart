// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_egresados/ui/pages/content/post/widget/post_edi.dart';
import 'package:red_egresados/ui/pages/content/statesP/widgets/state_edit.dart';
import 'widget/post_card.dart';

class PostScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const PostScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PostScreen> {
  final items = List<String>.generate(1, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostEdit(),
            // PostCard(
            //   title: 'Ludvig Wiese',
            //   content:
            //       'Duis non tellus sed quam luctus gravida quis sed libero. Pellentesque luctus lorem eu est varius, eu dignissim leo tincidunt. Fusce eget ante sed mi venenatis tincidunt et rutrum neque. Suspendisse laoreet sapien sed est aliquet fringilla. Fusce fringilla, ante in ultrices volutpat, mauris ',
            //   picUrl:
            //       'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
            //   onChat: () => {},
            // )
          ],
        );
      },
    );
  }
}
