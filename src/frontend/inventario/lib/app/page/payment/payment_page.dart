import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:inventario/app/page/shared_widget/input/input_imports.dart';
import 'package:inventario/app/controller/controller_imports.dart';
import 'package:inventario/app/infra/infra_imports.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - 100,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black87,
            onPressed: () {controller.preventDataLoss();}),
          elevation: 1,
          title: Text(
            'payment_title'.tr,
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            const SizedBox(width: 200,),
            TextButton(onPressed: () async { 
              await launchUrl(Uri.parse('https://t2tisistemas.com/t2tierp/#pricing'));
            }, 
            child: Text('payment_show_plans'.tr))
          ],
        ),
        body: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Scrollbar(
            controller: controller.scrollController,                  
            child: SingleChildScrollView(
              controller: controller.scrollController,
              dragStartBehavior: DragStartBehavior.down,
              child: BootstrapContainer(
                fluid: true,
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                children: <Widget>[			  			                          
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: Container(
                            width: double.maxFinite,
                            height: 100.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/payment-banner.jpg"),
                                fit: BoxFit.cover)
                              ),
                            child: Container(),                                
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-md-6',
                        child: TextFormField(
                          validator: ValidateFormField.validateMandatory,
                          maxLength: 18,
                          controller: controller.cnpjController,
                          onChanged: (text) {
                            controller.formWasChanged = true;
                          },
                          decoration: inputDecoration(
                            hintText: 'payment_document_number_hint'.tr,
                            labelText: "${'payment_document_number'.tr}*",
                            usePadding: true
                          ),
                        ),
                      ),                            
                      BootstrapCol(
                        sizes: 'col-12 col-md-6',
                        child: TextFormField(
                          maxLength: 200,
                          controller: controller.razaoSocialController,
                          validator: ValidateFormField.validateMandatory,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            controller.formWasChanged = true;
                          },                          
                          decoration: inputDecoration(
                            hintText: 'payment_razao_hint'.tr,
                            labelText: "${'payment_razao'.tr}*",
                            usePadding: true
                          ),
                        ),
                      ),                        
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-md-6',
                        child: TextFormField(
                          maxLength: 200,
                          controller: controller.nomeFantasiaController,
                          validator: ValidateFormField.validateMandatory,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            controller.formWasChanged = true;
                          },                          
                          decoration: inputDecoration(
                            hintText: 'payment_name_hint'.tr,
                            labelText: "${'payment_name'.tr}*",
                            usePadding: true
                          ),
                        ),
                      ),                            
                      BootstrapCol(
                        sizes: 'col-12 col-md-6',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            controller: controller.emailController,
                            maxLength: 250,
                            keyboardType: TextInputType.text,
                            validator: ValidateFormField.validateMandatoryEmail,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_email_hint'.tr,
                              labelText: "${'payment_email'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
                    child: Text(
                      'payment_address_title'.tr, 
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-md-4',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            validator: ValidateFormField.validateMandatory,
                            maxLength: 9,
                            controller: controller.cepController,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_address_zip_hint'.tr,
                              labelText: "${'payment_address_zip'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-md-8',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            validator: ValidateFormField.validateMandatory,
                            maxLength: 250,
                            controller: controller.logradouroController,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_address_street_hint'.tr,
                              labelText: "${'payment_address_street'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-md-3',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            validator: ValidateFormField.validateMandatory,
                            maxLength: 20,
                            controller: controller.numeroController,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_address_number_hint'.tr,
                              labelText: "${'payment_address_number'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-md-5',
                        child: TextFormField(
                          maxLength: 250,
                          controller: controller.complementoController,
                          onChanged: (text) {
                            controller.formWasChanged = true;
                          },                          
                          decoration: inputDecoration(
                            hintText: 'payment_address_complement_hint'.tr,
                            labelText: 'payment_address_complement'.tr,
                            usePadding: true
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-md-4',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            maxLength: 20,
                            controller: controller.foneController,
                            keyboardType: TextInputType.text,
                            decoration: inputDecoration(
                              hintText: 'payment_phone_hint'.tr,
                              labelText: 'payment_phone'.tr,
                              usePadding: true
                            ),
                          ),
                        ),
                      ),                      
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 60,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-md-5',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            validator: ValidateFormField.validateMandatory,
                            maxLength: 100,
                            controller: controller.bairroController,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_address_neighborhood_hint'.tr,
                              labelText: "${'payment_address_neighborhood'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-md-5',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: TextFormField(
                            validator: ValidateFormField.validateMandatory,
                            maxLength: 100,
                            controller: controller.cidadeController,
                            onChanged: (text) {
                              controller.formWasChanged = true;
                            },                          
                            decoration: inputDecoration(
                              hintText: 'payment_address_city_hint'.tr,
                              labelText: "${'payment_address_city'.tr}*",
                              usePadding: true
                            ),
                          ),
                        ),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-md-2',
                        child: Padding(
                          padding: Util.distanceBetweenColumnsLineBreak(context)!,
                          child: CustomDropdownButtonFormField(
                            value: controller.ufController.text.isEmpty ? 'AC' : controller.ufController.text,
                            labelText: 'payment_address_state'.tr,
                            hintText: 'payment_address_state_hint'.tr,
                            items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
                            onChanged: (dynamic newValue) {
                              controller.ufController.text = newValue;
                              controller.formWasChanged = true;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),                 
                  const Divider(color: Colors.white,),
                  BootstrapRow(
                    height: 20,
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12',
                        child: 
                          Text(
                            'field_is_mandatory'.tr,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),								
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white,),
                  _regiaoTipoPlano(context),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),			  
        ),
      ),
    );
  }

  Widget _regiaoTipoPlano(BuildContext context) {
    return Column(
      children: <Widget>[
        BootstrapContainer(                    
          fluid: true,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          children: <Widget>[			  			  
            BootstrapRow(
              height: 60,
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12',
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('payment_title'.tr,
                                  style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0),
                                ),
                                const SizedBox(width: 10,),
                                TextButton(onPressed: () async { 
                                  await launchUrl(Uri.parse('https://t2tisistemas.com/t2tierp/#pricing'));
                                  }, 
                                  child: Text('payment_show_plans'.tr)
                                )                                
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                          ),
                          Row(              
                            children: _loadPlanos(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),                          
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  List<Widget> _loadPlanos() {
    final List<Widget> listWidget = [];
    listWidget.add(
      const SizedBox(
        width: 10,
      ),
    );    
    for (var plano in Session.erpTipoPlanList) {
      listWidget.add(
        Expanded(
          flex: 1,
          child: _getTile(
            _getItemPlanoPagamento(
              plano.nome, 
              plano.valor, 
              Colors.blue.shade900, 
              plano.frequencia == 'MONTH'       
              ? Icons.calendar_month_outlined   // ícone mensal
              : plano.frequencia == 'YEAR'      
                ? Icons.looks_one               // ícone anual
                : Icons.six_mp,                 // ícone semestral
            ),
            onTap: () async {
              await controller.contratarPlano(plano);
            },
          ),
        ),
      );
      listWidget.add(
        const SizedBox(
          width: 10,
        ),
      );
    }
    return listWidget;
  }

  Widget _getTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () { debugPrint('Nada foi implementado'); },
            child: child));
  }

  Widget _getItemPlanoPagamento(String? descricao, double? valor, Color corIcone, IconData icone) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: corIcone,
            shape: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icone, color: Colors.white, size: 30.0),
            )),
          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
          Text(descricao ?? '', style: 
            const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            )
          ),
          Text(
            'R\$ ${valor ?? 0}', //valor            
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24)),
        ]
      ),
    );
  }

}
