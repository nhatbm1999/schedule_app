import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  const AccountItem(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.hasNotice,
      this.listItem = 0,
      required this.itemContent})
      : super(key: key);

  final Function() onTap;
  final Icon icon;
  final Text itemContent;
  final bool hasNotice;
  final int listItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasNotice == true
                  ? Stack(children: [
                      icon,
                      CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          listItem.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ])
                  : icon,
              const SizedBox(
                height: 15,
              ),
              itemContent
            ],
          ),
        ),
      ),
    );
  }
}
