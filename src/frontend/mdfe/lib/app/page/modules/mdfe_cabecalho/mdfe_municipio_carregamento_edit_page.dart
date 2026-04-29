import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_municipio_carregamento_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeMunicipioCarregamentoEditPage extends StatelessWidget {
	MdfeMunicipioCarregamentoEditPage({Key? key}) : super(key: key);
	final mdfeMunicipioCarregamentoController = Get.find<MdfeMunicipioCarregamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeMunicipioCarregamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Município Carregamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeMunicipioCarregamentoController.save),
						cancelAndExitButton(onPressed: mdfeMunicipioCarregamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeMunicipioCarregamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeMunicipioCarregamentoController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeMunicipioCarregamentoController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 7,
															controller: mdfeMunicipioCarregamentoController.codigoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio',
																labelText: 'Codigo Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeMunicipioCarregamentoController.mdfeMunicipioCarregamentoModel.codigoMunicipio = text;
																mdfeMunicipioCarregamentoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: mdfeMunicipioCarregamentoController.nomeMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio',
																labelText: 'Nome Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeMunicipioCarregamentoController.mdfeMunicipioCarregamentoModel.nomeMunicipio = text;
																mdfeMunicipioCarregamentoController.formWasChanged = true;
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
