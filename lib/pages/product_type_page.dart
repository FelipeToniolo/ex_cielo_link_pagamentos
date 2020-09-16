import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/widget/button_custom.dart';
import 'package:flutter/material.dart';

class ProductTypePage extends StatefulWidget {
  ProductTypePage({Key key, this.title = 'Flutter Demo Link de Pagamentos'})
      : super(key: key);

  final String title;

  @override
  _ProductTypePageState createState() => _ProductTypePageState();
}

class _ProductTypePageState extends State<ProductTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Informe o Tipo de Produto:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ButtonCustom(
                  'Físico', PaymentLinkRequest(type: TypeProduct.ASSET)),
              ButtonCustom(
                  'Digital', PaymentLinkRequest(type: TypeProduct.DIGITAL)),
              ButtonCustom(
                  'Serviços', PaymentLinkRequest(type: TypeProduct.SERVICE)),
              ButtonCustom(
                  'Pagamento', PaymentLinkRequest(type: TypeProduct.PAYMENT)),
              ButtonCustom('Recorrencia',
                  PaymentLinkRequest(type: TypeProduct.RECURRING_PAYMENT))
            ],
          ),
        ),
      ),
    );
  }
}
