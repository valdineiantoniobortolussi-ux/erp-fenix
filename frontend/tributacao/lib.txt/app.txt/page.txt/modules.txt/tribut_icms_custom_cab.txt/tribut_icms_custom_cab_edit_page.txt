import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_icms_custom_cab_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributIcmsCustomCabEditPage extends StatelessWidget {
	TributIcmsCustomCabEditPage({Key? key}) : super(key: key);
	final tributIcmsCustomCabController = Get.find<TributIcmsCustomCabController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributIcmsCustomCabController.tributIcmsCustomCabEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributIcmsCustomCabController.tributIcmsCustomCabEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributIcmsCustomCabController.scrollController,
							child: SingleChildScrollView(
								controller: tributIcmsCustomCabController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
									children: <Widget>[
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: tributIcmsCustomCabController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomCabController.tributIcmsCustomCabModel.descricao = text;
																tributIcmsCustomCabController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsCustomCabController.tributIcmsCustomCabModel.origemMercadoria ?? '0=Nacional',
															labelText: 'Origem Mercadoria',
															hintText: 'Informe os dados para o campo Origem Mercadoria',
															items: const ['0=Nacional','1=Estrangeira - Importação Direta','2=Estrangeira - Adquirida no Mercado Interno'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomCabController.tributIcmsCustomCabModel.origemMercadoria = newValue;
																tributIcmsCustomCabController.formWasChanged = true;
															},
														),
													),
												),
											],
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
													sizes: 'col-12',
													child: Text(
														'field_is_mandatory'.tr,
														style: Theme.of(context).textTheme.bodySmall,
													),
												),
											],
										),
										const SizedBox(height: 10.0),
									],
								),
							),
						),
					),
				),
			);
	}
}
