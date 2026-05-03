import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:comissoes/app/page/shared_widget/shared_widget_imports.dart';
import 'package:comissoes/app/controller/comissao_objetivo_controller.dart';
import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/page/shared_widget/input/input_imports.dart';

class ComissaoObjetivoEditPage extends StatelessWidget {
	ComissaoObjetivoEditPage({Key? key}) : super(key: key);
	final comissaoObjetivoController = Get.find<ComissaoObjetivoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					comissaoObjetivoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: comissaoObjetivoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Objetivos e Metas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: comissaoObjetivoController.save),
						cancelAndExitButton(onPressed: comissaoObjetivoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: comissaoObjetivoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: comissaoObjetivoController.scrollController,
							child: SingleChildScrollView(
								controller: comissaoObjetivoController.scrollController,
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
																		controller: comissaoObjetivoController.comissaoPerfilModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Perfil',
																			labelText: 'Perfil *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: comissaoObjetivoController.callComissaoPerfilLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 3,
															controller: comissaoObjetivoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.codigo = text;
																comissaoObjetivoController.formWasChanged = true;
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
															maxLength: 100,
															controller: comissaoObjetivoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.nome = text;
																comissaoObjetivoController.formWasChanged = true;
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
															controller: comissaoObjetivoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.descricao = text;
																comissaoObjetivoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: comissaoObjetivoController.taxaPagamentoController,
															decoration: inputDecoration(
																hintText: 'Percentual pago em cima do valo da meta, caso atingida',
																labelText: 'Taxa Pagamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.taxaPagamento = comissaoObjetivoController.taxaPagamentoController.numberValue;
																comissaoObjetivoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: comissaoObjetivoController.valorPagamentoController,
															decoration: inputDecoration(
																hintText: 'Valor pago em reais caso a meta seja atingida',
																labelText: 'Valor Pagamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.valorPagamento = comissaoObjetivoController.valorPagamentoController.numberValue;
																comissaoObjetivoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: comissaoObjetivoController.valorMetaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Meta',
																labelText: 'Valor Meta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoObjetivoController.comissaoObjetivoModel.valorMeta = comissaoObjetivoController.valorMetaController.numberValue;
																comissaoObjetivoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Data de início da meta',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: comissaoObjetivoController.comissaoObjetivoModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	comissaoObjetivoController.comissaoObjetivoModel.dataInicio = value;
																	comissaoObjetivoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Data de finalização da meta',
																labelText: 'Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: comissaoObjetivoController.comissaoObjetivoModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	comissaoObjetivoController.comissaoObjetivoModel.dataFim = value;
																	comissaoObjetivoController.formWasChanged = true;
																},
															),
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
			),
		);
	}
}
