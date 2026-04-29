import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimBemEditPage extends StatelessWidget {
	PatrimBemEditPage({Key? key}) : super(key: key);
	final patrimBemController = Get.find<PatrimBemController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: patrimBemController.patrimBemEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimBemController.patrimBemEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimBemController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.centroResultadoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Centro Resultado',
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
																child: lookupButton(onPressed: patrimBemController.callCentroResultadoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.viewPessoaFornecedorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Formecedor',
																			labelText: 'Fornecedor *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimBemController.callViewPessoaFornecedorLookup),
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
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: patrimBemController.callViewPessoaColaboradorLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.patrimTipoAquisicaoBemModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Aquisicao',
																			labelText: 'Tipo Aquisicao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimBemController.callPatrimTipoAquisicaoBemLookup),
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
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.patrimEstadoConservacaoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Estado Conservacao',
																			labelText: 'Estado Conservacao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimBemController.callPatrimEstadoConservacaoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.patrimGrupoBemModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Grupo',
																			labelText: 'Grupo *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimBemController.callPatrimGrupoBemLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: patrimBemController.setorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Setor',
																			labelText: 'Setor *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimBemController.callSetorLookup),
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
															maxLength: 20,
															controller: patrimBemController.numeroNbController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Bem',
																labelText: 'Numero Bem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.numeroNb = text;
																patrimBemController.formWasChanged = true;
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
															controller: patrimBemController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.nome = text;
																patrimBemController.formWasChanged = true;
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
															controller: patrimBemController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.descricao = text;
																patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Aquisicao',
																labelText: 'Data Aquisicao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataAquisicao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataAquisicao = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Aceite',
																labelText: 'Data Aceite',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataAceite,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataAceite = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Cadastro',
																labelText: 'Data Cadastro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataCadastro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataCadastro = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Contabilizado',
																labelText: 'Data Contabilizado',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataContabilizado,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataContabilizado = value;
																	patrimBemController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Vistoria',
																labelText: 'Data Vistoria',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataVistoria,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataVistoria = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Marcacao',
																labelText: 'Data Marcacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataMarcacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataMarcacao = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Baixa',
																labelText: 'Data Baixa',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.dataBaixa,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.dataBaixa = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Vencimento Garantia',
																labelText: 'Vencimento Garantia',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.vencimentoGarantia,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.vencimentoGarantia = value;
																	patrimBemController.formWasChanged = true;
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
															maxLength: 50,
															controller: patrimBemController.numeroNotaFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Nota Fiscal',
																labelText: 'Numero Nota Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.numeroNotaFiscal = text;
																patrimBemController.formWasChanged = true;
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
															maxLength: 50,
															controller: patrimBemController.numeroSerieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie',
																labelText: 'Numero Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.numeroSerie = text;
																patrimBemController.formWasChanged = true;
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
															maxLength: 44,
															controller: patrimBemController.chaveNfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Nfe',
																labelText: 'Chave Nfe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.chaveNfe = text;
																patrimBemController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.valorOriginalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Original',
																labelText: 'Valor Original',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.valorOriginal = patrimBemController.valorOriginalController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.valorCompraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Compra',
																labelText: 'Valor Compra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.valorCompra = patrimBemController.valorCompraController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.valorAtualizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Atualizado',
																labelText: 'Valor Atualizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.valorAtualizado = patrimBemController.valorAtualizadoController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.valorBaixaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Baixa',
																labelText: 'Valor Baixa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.valorBaixa = patrimBemController.valorBaixaController.numberValue;
																patrimBemController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: patrimBemController.patrimBemModel.deprecia ?? 'Sim',
															labelText: 'Deprecia',
															hintText: 'Informe os dados para o campo Deprecia',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																patrimBemController.patrimBemModel.deprecia = newValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: patrimBemController.patrimBemModel.metodoDepreciacao ?? '1=Linear',
															labelText: 'Metodo Depreciacao',
															hintText: 'Informe os dados para o campo Metodo Depreciacao',
															items: const ['1=Linear','2=Soma dos Algarismos dos Anos','3=Horas de Trabalho','4=Unidades Produzidas'],
															onChanged: (dynamic newValue) {
																patrimBemController.patrimBemModel.metodoDepreciacao = newValue;
																patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Inicio Depreciacao',
																labelText: 'Inicio Depreciacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.inicioDepreciacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.inicioDepreciacao = value;
																	patrimBemController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Ultima Depreciacao',
																labelText: 'Ultima Depreciacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimBemController.patrimBemModel.ultimaDepreciacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimBemController.patrimBemModel.ultimaDepreciacao = value;
																	patrimBemController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: patrimBemController.patrimBemModel.tipoDepreciacao ?? 'Normal',
															labelText: 'Tipo Depreciacao',
															hintText: 'Informe os dados para o campo Tipo Depreciacao',
															items: const ['Normal','Acelerada','Incentivada'],
															onChanged: (dynamic newValue) {
																patrimBemController.patrimBemModel.tipoDepreciacao = newValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.taxaAnualDepreciacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Anual Depreciacao',
																labelText: 'Taxa Anual Depreciacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.taxaAnualDepreciacao = patrimBemController.taxaAnualDepreciacaoController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.taxaMensalDepreciacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Mensal Depreciacao',
																labelText: 'Taxa Mensal Depreciacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.taxaMensalDepreciacao = patrimBemController.taxaMensalDepreciacaoController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.taxaDepreciacaoAceleradaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Depreciacao Acelerada',
																labelText: 'Taxa Depreciacao Acelerada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.taxaDepreciacaoAcelerada = patrimBemController.taxaDepreciacaoAceleradaController.numberValue;
																patrimBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimBemController.taxaDepreciacaoIncentivadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Depreciacao Incentivada',
																labelText: 'Taxa Depreciacao Incentivada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.taxaDepreciacaoIncentivada = patrimBemController.taxaDepreciacaoIncentivadaController.numberValue;
																patrimBemController.formWasChanged = true;
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
															controller: patrimBemController.funcaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Funcao',
																labelText: 'Funcao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimBemController.patrimBemModel.funcao = text;
																patrimBemController.formWasChanged = true;
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
