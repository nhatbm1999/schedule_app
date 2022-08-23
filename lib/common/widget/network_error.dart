import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({Key? key, required this.retry}) : super(key: key);

  final void Function()? retry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Oh, network disconnected. Please try again !'),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(onPressed: retry, child: const Text('Try again')),
        ],
      ),
    );
  }
}