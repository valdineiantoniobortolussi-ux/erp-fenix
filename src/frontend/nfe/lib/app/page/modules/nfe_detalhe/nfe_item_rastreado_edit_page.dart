import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_item_rastreado_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeItemRastreadoEditPage extends StatelessWidget {
	NfeItemRastreadoEditPage({Key? key}) : super(key: key);
	final nfeItemRastreadoController = Get.find<NfeItemRastreadoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeItemRastreadoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Item Rastreado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeItemRastreadoController.save),
						cancelAndExitButton(onPressed: nfeItemRastreadoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeItemRastreadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeItemRastreadoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeItemRastreadoController.scrollController,
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
															maxLength: 20,
															controller: nfeItemRastreadoController.numeroLoteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Lote',
																labelText: 'Numero Lote',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeItemRastreadoController.nfeItemRastreadoModel.numeroLote = text;
																nfeItemRastreadoController.formWasChanged = true;
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
															controller: nfeItemRastreadoController.quantidadeItensController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Itens',
																labelText: 'Quantidade Itens',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeItemRastreadoController.nfeItemRastreadoModel.quantidadeItens = nfeItemRastreadoController.quantidadeItensController.numberValue;
																nfeItemRastreadoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Fabricacao',
																labelText: 'Data Fabricacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeItemRastreadoController.nfeItemRastreadoModel.dataFabricacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeItemRastreadoController.nfeItemRastreadoModel.dataFabricacao = value;
																	nfeItemRastreadoController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Validade',
																labelText: 'Data Validade',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeItemRastreadoController.nfeItemRastreadoModel.dataValidade,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeItemRastreadoController.nfeItemRastreadoModel.dataValidade = value;
																	nfeItemRastreadoController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: nfeItemRastreadoController.codigoAgregacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Agregacao',
																labelText: 'Codigo Agregacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeItemRastreadoController.nfeItemRastreadoModel.codigoAgregacao = text;
																nfeItemRastreadoController.formWasChanged = true;
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
