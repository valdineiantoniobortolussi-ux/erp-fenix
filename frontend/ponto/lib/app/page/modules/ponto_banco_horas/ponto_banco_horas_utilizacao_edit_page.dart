import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_banco_horas_utilizacao_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoBancoHorasUtilizacaoEditPage extends StatelessWidget {
	PontoBancoHorasUtilizacaoEditPage({Key? key}) : super(key: key);
	final pontoBancoHorasUtilizacaoController = Get.find<PontoBancoHorasUtilizacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pontoBancoHorasUtilizacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Utilização - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoBancoHorasUtilizacaoController.save),
						cancelAndExitButton(onPressed: pontoBancoHorasUtilizacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoBancoHorasUtilizacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoBancoHorasUtilizacaoController.scrollController,
							child: SingleChildScrollView(
								controller: pontoBancoHorasUtilizacaoController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Utilizacao',
																labelText: 'Data Utilizacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pontoBancoHorasUtilizacaoController.pontoBancoHorasUtilizacaoModel.dataUtilizacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pontoBancoHorasUtilizacaoController.pontoBancoHorasUtilizacaoModel.dataUtilizacao = value;
																	pontoBancoHorasUtilizacaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoBancoHorasUtilizacaoController.quantidadeUtilizadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Utilizada',
																labelText: 'Quantidade Utilizada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoBancoHorasUtilizacaoController.pontoBancoHorasUtilizacaoModel.quantidadeUtilizada = text;
																pontoBancoHorasUtilizacaoController.formWasChanged = true;
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
															controller: pontoBancoHorasUtilizacaoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoBancoHorasUtilizacaoController.pontoBancoHorasUtilizacaoModel.observacao = text;
																pontoBancoHorasUtilizacaoController.formWasChanged = true;
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
