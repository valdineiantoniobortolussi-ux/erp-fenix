import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_processo_referenciado_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeProcessoReferenciadoEditPage extends StatelessWidget {
	NfeProcessoReferenciadoEditPage({Key? key}) : super(key: key);
	final nfeProcessoReferenciadoController = Get.find<NfeProcessoReferenciadoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeProcessoReferenciadoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Processo Referenciado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeProcessoReferenciadoController.save),
						cancelAndExitButton(onPressed: nfeProcessoReferenciadoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeProcessoReferenciadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeProcessoReferenciadoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeProcessoReferenciadoController.scrollController,
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: nfeProcessoReferenciadoController.identificadorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Identificador',
																labelText: 'Identificador',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProcessoReferenciadoController.nfeProcessoReferenciadoModel.identificador = text;
																nfeProcessoReferenciadoController.formWasChanged = true;
															},
														),
													),
												),
											],
										),
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeProcessoReferenciadoController.nfeProcessoReferenciadoModel.origem ?? 'AAA',
															labelText: 'Origem',
															hintText: 'Informe os dados para o campo Origem',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeProcessoReferenciadoController.nfeProcessoReferenciadoModel.origem = newValue;
																nfeProcessoReferenciadoController.formWasChanged = true;
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
