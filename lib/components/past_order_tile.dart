import 'package:flutter/material.dart';

class PastOrderTile extends StatelessWidget {
  const PastOrderTile({
    super.key,
    required this.dateString,
    required this.receipt,
  });

  final String dateString;
  final Map<String, dynamic> receipt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dateString,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surface,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(receipt["order"])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
