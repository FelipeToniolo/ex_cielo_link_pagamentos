import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/network/sendCielo.dart';
import 'package:example_cielo_payment_link/widget/button_confirm_custom.dart';
import 'package:example_cielo_payment_link/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';

class FormPackageDeliveryProductPage extends StatelessWidget {
  final PaymentLinkRequest request;

  FormPackageDeliveryProductPage({Key key, this.request}) : super(key: key);

  final sendCielo = SendCielo();

  final _controllerWeight = TextEditingController(text: '200');
  final _controllerLength = TextEditingController(text: '10');
  final _controllerWidth = TextEditingController(text: '10');
  final _controllerHeight = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Produto'),
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.body2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormFieldCustom(
                          controller: _controllerWeight,
                          labelText: 'Peso(gr)',
                          keyboardType: TextInputType.number,
                        ),
                        TextFormFieldCustom(
                          controller: _controllerLength,
                          labelText: 'Comprimento(cm)',
                          keyboardType: TextInputType.number,
                        ),
                        TextFormFieldCustom(
                          controller: _controllerWidth,
                          labelText: 'Largura(cm)',
                          keyboardType: TextInputType.number,
                        ),
                        TextFormFieldCustom(
                          controller: _controllerHeight,
                          labelText: 'Altura(cm)',
                          keyboardType: TextInputType.number,
                        ),
                        ButtonConfirmCustom(
                          onPressed: () {
                            request.shipping.package = PackageProduct(
                                weight: int.parse(_controllerWeight.text),
                                dimension: DimensionProduct(
                                    height: int.parse(_controllerHeight.text),
                                    length: int.parse(_controllerLength.text),
                                    width: int.parse(_controllerWidth.text)));

                            //CHAMADA CIELO PAYMENT LINK

                            sendCielo.paymentLink(
                                context: context, request: request);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
