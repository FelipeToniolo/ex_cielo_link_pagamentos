import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/pages/product_type_page.dart';
import 'package:example_cielo_payment_link/pages/response_page.dart';
import 'package:flutter/material.dart';

class SendCielo {
  paymentLink({BuildContext context, PaymentLinkRequest request}) async {
    try {
      //TODO: Tirar comentario de credenciais
      final paymentLink = PaymentLink(
        clientId: 'df66638b-3ef4-421f-a18e-e20dea38d97d',
        clientSecret: 'q13XZ48haFg4EhAS2cjcoyX7OzRECYysY6T9TJLmKNM=',
        environment: PaymentLinkEnvironment.SANDBOX,
      );

      var response = await paymentLink.create(request: request);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ResponsePage(response)),
          (Route<dynamic> route) => false);
    } on ErrorResponse catch (e) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProductTypePage()),
              (Route<dynamic> route) => false);
        },
      );

      WillPopScope alert = WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Link de Pagamentos'),
          content: Text(e.message),
          actions: [
            okButton,
          ],
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      print('--------------------------------------');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      print('--------------------------------------');
    }
  }
}
