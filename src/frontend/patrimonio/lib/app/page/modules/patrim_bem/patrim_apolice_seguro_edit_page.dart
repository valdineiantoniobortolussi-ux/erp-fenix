import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_apolice_seguro_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimApoliceSeguroEditPage extends StatelessWidget {
	PatrimApoliceSeguroEditPage({Key? key}) : super(key: key);
	final patrimApoliceSeguroController = Get.find<PatrimApoliceSeguroController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: patrimApoliceSeguroController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Apólices - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimApoliceSeguroController.save),
						cancelAndExitButton(onPressed: patrimApoliceSeguroController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimApoliceSeguroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimApoliceSeguroController.scrollController,
							child: SingleChildScrollView(
								controller: patrimApoliceSeguroController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimApoliceSeguroController.seguradoraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Seguradora',
																			labelText: 'Seguradora *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimApoliceSeguroController.callSeguradoraLookup),
															),
														],
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: patrimApoliceSeguroController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimApoliceSeguroController.patrimApoliceSeguroModel.numero = text;
																patrimApoliceSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Contratacao',
																labelText: 'Data Contratacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimApoliceSeguroController.patrimApoliceSeguroModel.dataContratacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimApoliceSeguroController.patrimApoliceSeguroModel.dataContratacao = value;
																	patrimApoliceSeguroController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Vencimento',
																labelText: 'Data Vencimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimApoliceSeguroController.patrimApoliceSeguroModel.dataVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimApoliceSeguroController.patrimApoliceSeguroModel.dataVencimento = value;
																	patrimApoliceSeguroController.formWasChanged = true;
																},
															),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimApoliceSeguroController.valorPremioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Premio',
																labelText: 'Valor Premio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimApoliceSeguroController.patrimApoliceSeguroModel.valorPremio = patrimApoliceSeguroController.valorPremioController.numberValue;
																patrimApoliceSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimApoliceSeguroController.valorSeguradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Segurado',
																labelText: 'Valor Segurado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimApoliceSeguroController.patrimApoliceSeguroModel.valorSegurado = patrimApoliceSeguroController.valorSeguradoController.numberValue;
																patrimApoliceSeguroController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLines: 3,
															controller: patrimApoliceSeguroController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimApoliceSeguroController.patrimApoliceSeguroModel.observacao = text;
																patrimApoliceSeguroController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLines: 3,
															controller: patrimApoliceSeguroController.imagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Imagem',
																labelText: 'Imagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimApoliceSeguroController.patrimApoliceSeguroModel.imagem = text;
																patrimApoliceSeguroController.formWasChanged = true;
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
