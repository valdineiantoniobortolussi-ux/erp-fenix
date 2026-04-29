import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_municipio_descarrega_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeMunicipioDescarregaEditPage extends StatelessWidget {
	MdfeMunicipioDescarregaEditPage({Key? key}) : super(key: key);
	final mdfeMunicipioDescarregaController = Get.find<MdfeMunicipioDescarregaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeMunicipioDescarregaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Município Descarrega - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeMunicipioDescarregaController.save),
						cancelAndExitButton(onPressed: mdfeMunicipioDescarregaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeMunicipioDescarregaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeMunicipioDescarregaController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeMunicipioDescarregaController.scrollController,
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
															controller: mdfeMunicipioDescarregaController.codigoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio',
																labelText: 'Codigo Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeMunicipioDescarregaController.mdfeMunicipioDescarregaModel.codigoMunicipio = text;
																mdfeMunicipioDescarregaController.formWasChanged = true;
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
															controller: mdfeMunicipioDescarregaController.nomeMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio',
																labelText: 'Nome Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeMunicipioDescarregaController.mdfeMunicipioDescarregaModel.nomeMunicipio = text;
																mdfeMunicipioDescarregaController.formWasChanged = true;
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
