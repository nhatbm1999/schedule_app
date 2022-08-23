import 'package:flutter/material.dart';
import 'package:schedule_app/account/bloc/account_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameDisplayWidget extends StatelessWidget {
  const NameDisplayWidget({
    Key? key,
    required this.accountState,
  }) : super(key: key);

  final AccountState accountState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Hi,',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                   color: CommonTheme().mainColor),
            ),
            const SizedBox(height: 10,),
            Text(
              accountState.user!.userName,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                   color: CommonTheme().mainColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // const SizedBox(
        //   width: 10,
        // ),
        // InkWell(
        //   onTap: () {
        //     showDialog(
        //         context: context,
        //         barrierDismissible: false,
        //         builder: (_) {
        //           return AlertDialog(
        //             shape: const RoundedRectangleBorder(
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(25),
        //               ),
        //             ),
        //             title: Assets.image.edit.image(width: 70, height: 70),
        //             content: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'Change your display name :',
        //                   style: Theme.of(context).textTheme.caption?.copyWith(
        //                       fontWeight: FontWeight.bold, fontSize: 14),
        //                 ),
        //                 const SizedBox(
        //                   height: 15,
        //                 ),
        //                 TextField(
        //                   controller: TextEditingController(
        //                       text: accountState.user!.userName),
        //                   onChanged: (name) {
        //                     context
        //                       .read<AccountBloc>()
        //                       .add(UserNameChanged(name: name));
        //                   },
        //                   decoration: InputDecoration(
        //                     contentPadding: const EdgeInsets.symmetric(
        //                         vertical: 10, horizontal: 10),
        //                     enabledBorder: OutlineInputBorder(
        //                       borderSide: const BorderSide(
        //                           width: 1, color: Colors.blue),
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(
        //                           width: 1, color: CommonTheme().mainColor),
        //                       borderRadius: BorderRadius.circular(5),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             actions: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   ElevatedButton.icon(
        //                     onPressed:  () {
        //                       context.read<AccountBloc>().add(ChangeUserName());
        //                       Navigator.of(context).pop();
        //                       context.read<AccountBloc>().add(GetUserInfo(userId: accountState.user!.id));
        //                     },
        //                     icon: const Icon(Icons.check),
        //                     label: const Text(
        //                       'OK',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     ),
        //                     style: ElevatedButton.styleFrom(
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(10),
        //                       ),
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     width: 15,
        //                   ),
        //                   ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     child: const Text('Cancel'),
        //                     style: ElevatedButton.styleFrom(
        //                         shape: RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                         ),
        //                         primary: Colors.redAccent),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           );
        //         });
        //   },
        //   child: Icon(
        //     Icons.edit,
        //     color: CommonTheme().mainColor,
        //   ),
        // )
      ],
    );
  }
}
