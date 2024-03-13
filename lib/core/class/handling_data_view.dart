import 'package:flutter/material.dart';
import 'status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return const Center(
        child: CircularProgressIndicator(), // Placeholder for loading widget
      );
    } else if (statusRequest == StatusRequest.offlineFailure) {
      return const Center(
        child: Text('Offline Failure'), // Placeholder for offline failure widget
      );
    } else if (statusRequest == StatusRequest.serverFailure) {
      return const Center(
        child: Text('Server Failure'), // Placeholder for server failure widget
      );
    } else if (statusRequest == StatusRequest.failure) {
      return const Center(
        child: Text('Generic Failure'), // Placeholder for generic failure widget
      );
    } else {
      return widget;
    }
  }
}
