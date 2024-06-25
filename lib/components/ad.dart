import 'package:flutter/material.dart';

class MockAd extends StatelessWidget {
  final VoidCallback onClose;

  MockAd({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 250,
        color: Colors.blueAccent,
        child: Stack(
          children: [
            Center(
              child: Text(
                'MILO ADS',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}