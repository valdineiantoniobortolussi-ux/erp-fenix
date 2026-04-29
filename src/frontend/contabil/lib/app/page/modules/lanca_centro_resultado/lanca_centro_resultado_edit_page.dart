import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/lanca_centro_resultado_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class LancaCentroResultadoEditPage extends StatelessWidget {
	LancaCentroResultadoEditPage({Key? key}) : super(key: key);
	final lancaCentroResultadoController = Get.find<LancaCentroResultadoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					lancaCentroResultadoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: lancaCentroResultadoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Lançamento Centro Resultado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: lancaCentroResultadoController.save),
						cancelAndExitButton(onPressed: lancaCentroResultadoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: lancaCentroResultadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: lancaCentroResultadoController.scrollController,
							child: SingleChildScrollView(
								controller: lancaCentroResultadoController.scrollController,
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
																		controller: lancaCentroResultadoController.centroResultadoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Centro Resultado',
																			labelText: 'Centro Resultado *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: lancaCentroResultadoController.callCentroResultadoLookup),
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
															controller: lancaCentroResultadoController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancaCentroResultadoController.lancaCentroResultadoModel.valor = lancaCentroResultadoController.valorController.numberValue;
																lancaCentroResultadoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Lancamento',
																labelText: 'Data Lancamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: lancaCentroResultadoController.lancaCentroResultadoModel.dataLancamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	lancaCentroResultadoController.lancaCentroResultadoModel.dataLancamento = value;
																	lancaCentroResultadoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: lancaCentroResultadoController.lancaCentroResultadoModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	lancaCentroResultadoController.lancaCentroResultadoModel.dataInclusao = value;
																	lancaCentroResultadoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: lancaCentroResultadoController.lancaCentroResultadoModel.origemDeRateio ?? 'Sim',
															labelText: 'Origem De Rateio',
															hintText: 'Informe os dados para o campo Origem De Rateio',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																lancaCentroResultadoController.lancaCentroResultadoModel.origemDeRateio = newValue;
																lancaCentroResultadoController.formWasChanged = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: lancaCentroResultadoController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Historico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancaCentroResultadoController.lancaCentroResultadoModel.historico = text;
																lancaCentroResultadoController.formWasChanged = true;
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
			),
		);
	}
}
