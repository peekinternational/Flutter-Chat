import 'package:flutter/material.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;


  ErrorRetryWidget(this.error, this.onRetry);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          error,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text(
            'Try Again',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
