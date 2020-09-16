import 'package:cielo_payment_link/payment_link.dart';
import 'package:example_cielo_payment_link/network/sendCielo.dart';
import 'package:example_cielo_payment_link/pages/form_package_delivery_product_page.dart';
import 'package:example_cielo_payment_link/widget/button_confirm_custom.dart';
import 'package:example_cielo_payment_link/widget/text_form_field_custom.dart';
import 'package:flutter/material.dart';

class FormDeliveryTypeProductPage extends StatefulWidget {
  final PaymentLinkRequest request;

  FormDeliveryTypeProductPage({Key key, this.request}) : super(key: key);

  @override
  _FormDeliveryTypeProductPageState createState() =>
      _FormDeliveryTypeProductPageState();
}

class _FormDeliveryTypeProductPageState
    extends State<FormDeliveryTypeProductPage> {
  final sendCielo = SendCielo();
  List<DropdownMenuItem<ShippingType>> _dropDownMenuItems;
  ShippingType _shippingTypeSelect;
  final _controllerName = TextEditingController(text: 'Entrega Domiciliar');
  final _controllerPrice = TextEditingController(text: '2000');
  final _controllerStreet =
      TextEditingController(text: 'Rua Alice Manholer Piteri');
  final _controllerNumber = TextEditingController(text: '2093');
  final _controllerDistrict = TextEditingController(text: 'Osasco');
  final _controllerCity = TextEditingController(text: 'São Paulo');
  final _controllerState = TextEditingController(text: 'SP');
  final _controllerZipCode = TextEditingController(text: '06018160');
  final _controllerComplement = TextEditingController(text: 'Casa 2');
  final _controllerPhone = TextEditingController(text: '11987654321');
  final _controllerDeliveryInstructions =
      TextEditingController(text: 'Sem instruções');

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _shippingTypeSelect = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de Entrega'),
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
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: DropdownButton(
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            value: _shippingTypeSelect,
                            items: _dropDownMenuItems,
                            onChanged: _changedDropDownItems,
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _textFieldFormDelivery(_shippingTypeSelect),
                            ],
                          ),
                        ),
                        ButtonConfirmCustom(
                          onPressed: () {
                            if (_shippingTypeSelect == ShippingType.CORREIOS ||
                                _shippingTypeSelect ==
                                    ShippingType.FIXEDAMOUNT) {
                              widget.request.shipping = ShippingProduct(
                                  type: _shippingTypeSelect,
                                  name: _controllerName.text,
                                  price: _controllerPrice.text,
                                  originZipcode: _controllerZipCode.text);

                              //CHAMADA LINK

                              sendCielo.paymentLink(
                                  context: context, request: widget.request);
                            } else if (_shippingTypeSelect ==
                                ShippingType.LOGGI) {
                              widget.request.shipping = ShippingProduct(
                                  type: _shippingTypeSelect,
                                  pickupData: PickupDataProduct(
                                      street: _controllerStreet.text,
                                      number: _controllerNumber.text,
                                      district: _controllerDistrict.text,
                                      city: _controllerCity.text,
                                      state: _controllerState.text,
                                      zipCode: _controllerZipCode.text,
                                      complement: _controllerComplement.text,
                                      contactPhone: _controllerPhone.text,
                                      deliveryInstructions:
                                          _controllerDeliveryInstructions
                                              .text));

                              //ABRE PAGINA DE DADOS DO PACOTE

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FormPackageDeliveryProductPage(
                                          request: widget.request),
                                ),
                              );
                            } else {
                              widget.request.shipping = ShippingProduct(
                                type: _shippingTypeSelect,
                              );
                              sendCielo.paymentLink(
                                  context: context, request: widget.request);
                            }
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

  List<DropdownMenuItem<ShippingType>> getDropDownMenuItems() {
    List<DropdownMenuItem<ShippingType>> items = List();
    if (widget.request.type == TypeProduct.ASSET) {
      items.add(
        DropdownMenuItem(
          value: ShippingType.FREE,
          child: Text('GRÁTIS'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.CORREIOS,
          child: Text('CORREIOS'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.FIXEDAMOUNT,
          child: Text('VALOR FIXO'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.LOGGI,
          child: Text('LOGGI'),
        ),
      );
    } else if (widget.request.type == TypeProduct.DIGITAL ||
        widget.request.type == TypeProduct.SERVICE) {
      items.add(
        DropdownMenuItem(
          value: ShippingType.WITHOUTSHIPPING,
          child: Text('SEM ENTREGA'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.WITHOUTSHIPPINGPICKUP,
          child: Text('RETIRADA LOJA'),
        ),
      );
    } else if (widget.request.type == TypeProduct.RECURRING_PAYMENT) {
      items.add(
        DropdownMenuItem(
          value: ShippingType.WITHOUTSHIPPING,
          child: Text('SEM ENTREGA'),
        ),
      );
    } else {
      items.add(
        DropdownMenuItem(
          value: ShippingType.FREE,
          child: Text('GRÁTIS'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.CORREIOS,
          child: Text('CORREIOS'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.FIXEDAMOUNT,
          child: Text('VALOR FIXO'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.LOGGI,
          child: Text('LOGGI'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.WITHOUTSHIPPING,
          child: Text('SEM ENTREGA'),
        ),
      );
      items.add(
        DropdownMenuItem(
          value: ShippingType.WITHOUTSHIPPINGPICKUP,
          child: Text('RETIRADA LOJA'),
        ),
      );
    }
    return items;
  }

  _changedDropDownItems(ShippingType selectedItem) {
    setState(() {
      _shippingTypeSelect = selectedItem;
      _textFieldFormDelivery(_shippingTypeSelect);
    });
  }

  _textFieldFormDelivery(ShippingType type) {
    if (type == ShippingType.FREE ||
        type == ShippingType.WITHOUTSHIPPING ||
        type == ShippingType.WITHOUTSHIPPINGPICKUP) {
      return Container();
    } else if (type == ShippingType.FIXEDAMOUNT ||
        type == ShippingType.CORREIOS) {
      return Container(
        child: Column(
          children: <Widget>[
            TextFormFieldCustom(
                controller: _controllerName, labelText: 'Nome da Entrega'),
            TextFormFieldCustom(
              controller: _controllerPrice,
              labelText: 'Valor da Entrega',
              keyboardType: TextInputType.number,
            ),
            TextFormFieldCustom(
              controller: _controllerZipCode,
              labelText: 'CEP',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            TextFormFieldCustom(
                controller: _controllerStreet,
                labelText: 'Endereço de Entrega'),
            TextFormFieldCustom(
                controller: _controllerNumber,
                labelText: 'Numero',
                keyboardType: TextInputType.number),
            TextFormFieldCustom(
                controller: _controllerDistrict, labelText: 'Municipio'),
            TextFormFieldCustom(
                controller: _controllerCity, labelText: 'Cidade'),
            TextFormFieldCustom(
                controller: _controllerState, labelText: 'Estado'),
            TextFormFieldCustom(
                controller: _controllerZipCode, labelText: 'CEP'),
            TextFormFieldCustom(
                controller: _controllerComplement, labelText: 'Complemento'),
            TextFormFieldCustom(
                controller: _controllerPhone, labelText: 'Telefone'),
            TextFormFieldCustom(
                controller: _controllerDeliveryInstructions,
                labelText: 'Instruções de Entrega'),
          ],
        ),
      );
    }
  }
}
