import 'package:book_swap_ai/components/models/services.dart';
import 'package:book_swap_ai/consts.dart';
import 'package:book_swap_ai/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});
  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          // color: chatIndex == 0 ? scaffoldBackgroundColor: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  chatIndex==0? AssetsImage.userLogo:AssetsImage.userImage,
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  width: 8,
                ),

                Expanded(
                  child: TextWidget(
                    label: msg,
                  ),
                )  
              ],
            ),
          ),
        )
      ],

    );
  }
}