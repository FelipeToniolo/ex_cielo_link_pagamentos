import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/pages/form_delivery_type_product_page.dart';
import 'package:example_cielo_payment_link/pages/form_recurrence_data_page.dart';
import 'package:example_cielo_payment_link/widget/button_confirm_custom.dart';
import 'package:example_cielo_payment_link/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';

class FormProductPage extends StatelessWidget {
  final PaymentLinkRequest request;
  FormProductPage({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controllerName = TextEditingController(text: 'Produto Teste');
    final _controllerDescription =
        TextEditingController(text: 'Descrição do Produto');
    final _controllerPrice = TextEditingController(text: '100000');

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
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextFormFieldCustom(
                              controller: _controllerName,
                              labelText: 'Nome do Produto'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: TextFormFieldCustom(
                              controller: _controllerDescription,
                              labelText: 'Descrição do Produto'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: TextFormFieldCustom(
                            controller: _controllerPrice,
                            labelText: 'Preço',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        ButtonConfirmCustom(onPressed: () {
                          request.name = _controllerName.text;
                          request.description = _controllerDescription.text;
                          request.price = _controllerPrice.text;

                          if (request.type != TypeProduct.RECURRING_PAYMENT) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FormDeliveryTypeProductPage(
                                            request: request)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FormRecurrenceDataPage(
                                            request: request)));
                          }
                        }),
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
