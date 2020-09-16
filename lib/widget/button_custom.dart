import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/pages/form_product_page.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  String text;
  PaymentLinkRequest request;

  ButtonCustom(this.text, this.request);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormProductPage(
                            request: request,
                          )));
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.black38, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
