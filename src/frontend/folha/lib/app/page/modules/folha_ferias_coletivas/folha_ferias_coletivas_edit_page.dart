import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_ferias_coletivas_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaFeriasColetivasEditPage extends StatelessWidget {
	FolhaFeriasColetivasEditPage({Key? key}) : super(key: key);
	final folhaFeriasColetivasController = Get.find<FolhaFeriasColetivasController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaFeriasColetivasController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaFeriasColetivasController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Férias Coletivas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaFeriasColetivasController.save),
						cancelAndExitButton(onPressed: folhaFeriasColetivasController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaFeriasColetivasController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaFeriasColetivasController.scrollController,
							child: SingleChildScrollView(
								controller: folhaFeriasColetivasController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaFeriasColetivasController.folhaFeriasColetivasModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaFeriasColetivasController.folhaFeriasColetivasModel.dataInicio = value;
																	folhaFeriasColetivasController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Fim',
																labelText: 'Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaFeriasColetivasController.folhaFeriasColetivasModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaFeriasColetivasController.folhaFeriasColetivasModel.dataFim = value;
																	folhaFeriasColetivasController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaFeriasColetivasController.diasGozoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Gozo',
																labelText: 'Dias Gozo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaFeriasColetivasController.folhaFeriasColetivasModel.diasGozo = int.tryParse(text);
																folhaFeriasColetivasController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Abono Pecuniario Inicio',
																labelText: 'Abono Pecuniario Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaFeriasColetivasController.folhaFeriasColetivasModel.abonoPecuniarioInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaFeriasColetivasController.folhaFeriasColetivasModel.abonoPecuniarioInicio = value;
																	folhaFeriasColetivasController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Abono Pecuniario Fim',
																labelText: 'Abono Pecuniario Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaFeriasColetivasController.folhaFeriasColetivasModel.abonoPecuniarioFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaFeriasColetivasController.folhaFeriasColetivasModel.abonoPecuniarioFim = value;
																	folhaFeriasColetivasController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaFeriasColetivasController.diasAbonoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Abono',
																labelText: 'Dias Abono',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaFeriasColetivasController.folhaFeriasColetivasModel.diasAbono = int.tryParse(text);
																folhaFeriasColetivasController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaFeriasColetivasController.folhaFeriasColetivasModel.dataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaFeriasColetivasController.folhaFeriasColetivasModel.dataPagamento = value;
																	folhaFeriasColetivasController.formWasChanged = true;
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
