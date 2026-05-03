import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/colaborador_relacionamento_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class ColaboradorRelacionamentoEditPage extends StatelessWidget {
	ColaboradorRelacionamentoEditPage({Key? key}) : super(key: key);
	final colaboradorRelacionamentoController = Get.find<ColaboradorRelacionamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: colaboradorRelacionamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Relacionamentos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: colaboradorRelacionamentoController.save),
						cancelAndExitButton(onPressed: colaboradorRelacionamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: colaboradorRelacionamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: colaboradorRelacionamentoController.scrollController,
							child: SingleChildScrollView(
								controller: colaboradorRelacionamentoController.scrollController,
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
																		controller: colaboradorRelacionamentoController.tipoRelacionamentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Tipo Relacionamento',
																			labelText: 'Tipo Relacionamento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: colaboradorRelacionamentoController.callTipoRelacionamentoLookup),
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: colaboradorRelacionamentoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.nome = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Nascimento',
																labelText: 'Data Nascimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: colaboradorRelacionamentoController.colaboradorRelacionamentoModel.dataNascimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	colaboradorRelacionamentoController.colaboradorRelacionamentoModel.dataNascimento = value;
																	colaboradorRelacionamentoController.formWasChanged = true;
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
															controller: colaboradorRelacionamentoController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf',
																labelText: 'CPF',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.cpf = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															maxLength: 50,
															controller: colaboradorRelacionamentoController.registroMatriculaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Matricula',
																labelText: 'Registro Matricula',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.registroMatricula = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															maxLength: 50,
															controller: colaboradorRelacionamentoController.registroCartorioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Cartorio',
																labelText: 'Registro Cartorio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.registroCartorio = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															maxLength: 50,
															controller: colaboradorRelacionamentoController.registroCartorioNumeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Cartorio Numero',
																labelText: 'Registro Cartorio Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.registroCartorioNumero = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															maxLength: 10,
															controller: colaboradorRelacionamentoController.registroNumeroLivroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Numero Livro',
																labelText: 'Registro Numero Livro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.registroNumeroLivro = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															maxLength: 10,
															controller: colaboradorRelacionamentoController.registroNumeroFolhaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Numero Folha',
																labelText: 'Registro Numero Folha',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.registroNumeroFolha = text;
																colaboradorRelacionamentoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Entrega Documento',
																labelText: 'Data Entrega Documento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: colaboradorRelacionamentoController.colaboradorRelacionamentoModel.dataEntregaDocumento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	colaboradorRelacionamentoController.colaboradorRelacionamentoModel.dataEntregaDocumento = value;
																	colaboradorRelacionamentoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: colaboradorRelacionamentoController.colaboradorRelacionamentoModel.salarioFamilia ?? 'Sim',
															labelText: 'Salario Familia',
															hintText: 'Informe os dados para o campo Salario Familia',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.salarioFamilia = newValue;
																colaboradorRelacionamentoController.formWasChanged = true;
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
															controller: colaboradorRelacionamentoController.salarioFamiliaIdadeLimiteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Salario Familia Idade Limite',
																labelText: 'Salario Familia Idade Limite',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.salarioFamiliaIdadeLimite = int.tryParse(text);
																colaboradorRelacionamentoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Salario Familia Data Fim',
																labelText: 'Salario Familia Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: colaboradorRelacionamentoController.colaboradorRelacionamentoModel.salarioFamiliaDataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	colaboradorRelacionamentoController.colaboradorRelacionamentoModel.salarioFamiliaDataFim = value;
																	colaboradorRelacionamentoController.formWasChanged = true;
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
															controller: colaboradorRelacionamentoController.impostoRendaIdadeLimiteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Imposto Renda Idade Limite',
																labelText: 'Imposto Renda Idade Limite',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.impostoRendaIdadeLimite = int.tryParse(text);
																colaboradorRelacionamentoController.formWasChanged = true;
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
															controller: colaboradorRelacionamentoController.impostoRendaDataFimController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Imposto Renda Data Fim',
																labelText: 'Imposto Renda Data Fim',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																colaboradorRelacionamentoController.colaboradorRelacionamentoModel.impostoRendaDataFim = int.tryParse(text);
																colaboradorRelacionamentoController.formWasChanged = true;
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
