import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_parametro_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalParametroEditPage extends StatelessWidget {
	FiscalParametroEditPage({Key? key}) : super(key: key);
	final fiscalParametroController = Get.find<FiscalParametroController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: fiscalParametroController.fiscalParametroEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalParametroController.fiscalParametroEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalParametroController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalParametroController.scrollController,
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
																		controller: fiscalParametroController.fiscalEstadualPorteModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Porte Estadual',
																			labelText: 'Porte Estadual',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: fiscalParametroController.callFiscalEstadualPorteLookup),
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
																		controller: fiscalParametroController.fiscalEstadualRegimeModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Regime Estadual',
																			labelText: 'Regime Estadual',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: fiscalParametroController.callFiscalEstadualRegimeLookup),
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
																		controller: fiscalParametroController.fiscalMunicipalRegimeModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Regime Municipal',
																			labelText: 'Regime Municipal',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: fiscalParametroController.callFiscalMunicipalRegimeLookup),
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
															controller: fiscalParametroController.vigenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Vigencia',
																labelText: 'Vigencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalParametroController.fiscalParametroModel.vigencia = text;
																fiscalParametroController.formWasChanged = true;
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
															controller: fiscalParametroController.descricaoVigenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao Vigencia',
																labelText: 'Descricao Vigencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalParametroController.fiscalParametroModel.descricaoVigencia = text;
																fiscalParametroController.formWasChanged = true;
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
															value: fiscalParametroController.fiscalParametroModel.criterioLancamento ?? 'Livre',
															labelText: 'Criterio Lancamento',
															hintText: 'Informe os dados para o campo Criterio Lancamento',
															items: const ['Livre','Avisar','Não Permitir'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.criterioLancamento = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.apuracao ?? '1-Regime Competencia',
															labelText: 'Apuracao',
															hintText: 'Informe os dados para o campo Apuracao',
															items: const ['1-Regime Competencia','2-Regime de Caixa'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.apuracao = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.microempreeIndividual ?? 'Sim',
															labelText: 'Microempree Individual',
															hintText: 'Informe os dados para o campo Microempree Individual',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.microempreeIndividual = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.calcPisCofinsEfd ?? 'AB=Alíquota Básica',
															labelText: 'Calc Pis Cofins Efd',
															hintText: 'Informe os dados para o campo Calc Pis Cofins Efd',
															items: const ['AB=Alíquota Básica','AD=Alíquota Diferenciada','UP=Unidade de Medida de Produto'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.calcPisCofinsEfd = newValue;
																fiscalParametroController.formWasChanged = true;
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
															maxLength: 50,
															controller: fiscalParametroController.simplesCodigoAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Simples Codigo Acesso',
																labelText: 'Simples Codigo Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalParametroController.fiscalParametroModel.simplesCodigoAcesso = text;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.simplesTabela ?? '1=Federal',
															labelText: 'Simples Tabela',
															hintText: 'Informe os dados para o campo Simples Tabela',
															items: const ['1=Federal','2=Estadual'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.simplesTabela = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.simplesAtividade ?? 'Comercio',
															labelText: 'Simples Atividade',
															hintText: 'Informe os dados para o campo Simples Atividade',
															items: const ['Comercio','Indústria','Serviços Anexo III','Serviços Anexo IV','"Serviços Anexo V'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.simplesAtividade = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.perfilSped ?? 'A',
															labelText: 'Perfil Sped',
															hintText: 'Informe os dados para o campo Perfil Sped',
															items: const ['A','B','C'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.perfilSped = newValue;
																fiscalParametroController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.apuracaoConsolidada ?? 'Sim',
															labelText: 'Apuracao Consolidada',
															hintText: 'Informe os dados para o campo Apuracao Consolidada',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.apuracaoConsolidada = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.substituicaoTributaria ?? 'Sim',
															labelText: 'Substituicao Tributaria',
															hintText: 'Informe os dados para o campo Substituicao Tributaria',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.substituicaoTributaria = newValue;
																fiscalParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalParametroController.fiscalParametroModel.formaCalculoIss ?? 'Normal',
															labelText: 'Forma Calculo Iss',
															hintText: 'Informe os dados para o campo Forma Calculo Iss',
															items: const ['Normal','Profissional Habilitado','Valor Fixo'],
															onChanged: (dynamic newValue) {
																fiscalParametroController.fiscalParametroModel.formaCalculoIss = newValue;
																fiscalParametroController.formWasChanged = true;
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
