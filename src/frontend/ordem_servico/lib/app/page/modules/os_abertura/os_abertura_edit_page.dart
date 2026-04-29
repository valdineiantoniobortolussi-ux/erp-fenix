import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ordem_servico/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ordem_servico/app/controller/os_abertura_controller.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/input/input_imports.dart';

class OsAberturaEditPage extends StatelessWidget {
	OsAberturaEditPage({Key? key}) : super(key: key);
	final osAberturaController = Get.find<OsAberturaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: osAberturaController.osAberturaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: osAberturaController.osAberturaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: osAberturaController.scrollController,
							child: SingleChildScrollView(
								controller: osAberturaController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: osAberturaController.osStatusModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Status',
																			labelText: 'Status *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: osAberturaController.callOsStatusLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: osAberturaController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: osAberturaController.callViewPessoaColaboradorLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: osAberturaController.viewPessoaClienteModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Cliente',
																			labelText: 'Cliente *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: osAberturaController.callViewPessoaClienteLookup),
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
															controller: osAberturaController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.numero = text;
																osAberturaController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: osAberturaController.osAberturaModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	osAberturaController.osAberturaModel.dataInicio = value;
																	osAberturaController.formWasChanged = true;
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
															maxLength: 8,
															controller: osAberturaController.horaInicioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Inicio',
																labelText: 'Hora Inicio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.horaInicio = text;
																osAberturaController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Previsao',
																labelText: 'Data Previsao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: osAberturaController.osAberturaModel.dataPrevisao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	osAberturaController.osAberturaModel.dataPrevisao = value;
																	osAberturaController.formWasChanged = true;
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
															controller: osAberturaController.horaPrevisaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Previsao',
																labelText: 'Hora Previsao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.horaPrevisao = text;
																osAberturaController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Fim',
																labelText: 'Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: osAberturaController.osAberturaModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	osAberturaController.osAberturaModel.dataFim = value;
																	osAberturaController.formWasChanged = true;
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
															controller: osAberturaController.horaFimController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Fim',
																labelText: 'Hora Fim',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.horaFim = text;
																osAberturaController.formWasChanged = true;
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: osAberturaController.nomeContatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Contato',
																labelText: 'Nome Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.nomeContato = text;
																osAberturaController.formWasChanged = true;
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
															controller: osAberturaController.foneContatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fone Contato',
																labelText: 'Fone Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.foneContato = text;
																osAberturaController.formWasChanged = true;
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
															controller: osAberturaController.observacaoClienteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao Cliente',
																labelText: 'Observacao Cliente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.observacaoCliente = text;
																osAberturaController.formWasChanged = true;
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
															controller: osAberturaController.observacaoAberturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao Abertura',
																labelText: 'Observacao Abertura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaController.osAberturaModel.observacaoAbertura = text;
																osAberturaController.formWasChanged = true;
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
