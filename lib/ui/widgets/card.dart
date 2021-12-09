import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? topLeftWidget, topRightWidget, content, extraContent;
  final String title;

  // AppCard constructor
  const AppCard(
      {Key? key,
      required this.title,
      this.content,
      this.topLeftWidget,
      this.topRightWidget,
      this.extraContent})
      : super(
          key: key,
        );

  // Building basic card style
  // With the option to modify its content
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[30],
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                topLeftWidget != null
                    ? topLeftWidget!
                    : const SizedBox(
                        width: 48.0,
                      ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                topRightWidget != null
                    ? topRightWidget!
                    : const SizedBox(
                        width: 48.0,
                      ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: content,
              ),
            if (extraContent != null)
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: extraContent,
              ),
          ],
        ),
      ),
    );
  }
}
