import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                child: Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DeliveryProgressPage(),
                  ));
                },
                child: Text("Yes")),
          ],
          title: Text("Confirm payment"),
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
          title: Text("Checkout"),
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
              SizedBox(
                height: 25,
              ),
              CustomButton(
                  onTap: () {
                    userTappedPay();
                  },
                  text: "Pay now"),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
