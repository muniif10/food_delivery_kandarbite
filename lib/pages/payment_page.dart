import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:food_delivery_kandarbite/pages/delivery_progress_page.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      // If valid card details
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => FullScreenImage(),
                  );
                },
                child: const Text("Yes")),
          ],
          title: const Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Data: $expiryDate"),
                Text("Card Holder name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CreditCardWidget(
                isHolderNameVisible: true,
                cardHolderName: cardHolderName,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                expiryDate: expiryDate,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (p0) {},
              ),
              CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (data) {
                    setState(() {
                      cardNumber = data.cardNumber;
                      expiryDate = data.expiryDate;
                      cardHolderName = data.cardHolderName;
                      cvvCode = data.cvvCode;
                    });
                  },
                  formKey: formKey),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                  onTap: () {
                    userTappedPay();
                  },
                  text: "Pay now"),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          // Full screen image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/ads.jpg', // Replace with your image URL
              fit: BoxFit.fitWidth,
            ),
          ),
          // Close button
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DeliveryProgressPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
