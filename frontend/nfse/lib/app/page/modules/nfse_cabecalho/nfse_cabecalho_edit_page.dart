import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfse/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfse/app/controller/nfse_cabecalho_controller.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/page/shared_widget/input/input_imports.dart';

class NfseCabecalhoEditPage extends StatelessWidget {
	NfseCabecalhoEditPage({Key? key}) : super(key: key);
	final nfseCabecalhoController = Get.find<NfseCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfseCabecalhoController.nfseCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfseCabecalhoController.nfseCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfseCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: nfseCabecalhoController.scrollController,
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
													sizes: 'col-12 col-md-8',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: nfseCabecalhoController.viewPessoaClienteModelController,
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
																child: lookupButton(onPressed: nfseCabecalhoController.callViewPessoaClienteLookup),
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
																		controller: nfseCabecalhoController.osAberturaModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Número OS',
																			labelText: 'Número OS',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfseCabecalhoController.callOsAberturaLookup),
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
															maxLength: 15,
															controller: nfseCabecalhoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.numero = text;
																nfseCabecalhoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfseCabecalhoController.codigoVerificacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Verificacao',
																labelText: 'Codigo Verificacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.codigoVerificacao = text;
																nfseCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Hora Emissao',
																labelText: 'Data Hora Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfseCabecalhoController.nfseCabecalhoModel.dataHoraEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfseCabecalhoController.nfseCabecalhoModel.dataHoraEmissao = value;
																	nfseCabecalhoController.formWasChanged = true;
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
															controller: nfseCabecalhoController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.competencia = text;
																nfseCabecalhoController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfseCabecalhoController.numeroSubstituidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Substituida',
																labelText: 'Numero Substituida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.numeroSubstituida = text;
																nfseCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfseCabecalhoController.nfseCabecalhoModel.naturezaOperacao ?? '1=Tributação no município',
															labelText: 'Natureza Operacao',
															hintText: 'Informe os dados para o campo Natureza Operacao',
															items: const ['1=Tributação no município','2=Tributação fora do município','3=Isenção','4=Imune','5=Exigibilidade suspensa por decisão judicial','6=Exigibilidade suspensa por procedimento administrativo'],
															onChanged: (dynamic newValue) {
																nfseCabecalhoController.nfseCabecalhoModel.naturezaOperacao = newValue;
																nfseCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfseCabecalhoController.nfseCabecalhoModel.regimeEspecialTributacao ?? '1=Microempresa Municipal',
															labelText: 'Regime Especial Tributacao',
															hintText: 'Informe os dados para o campo Regime Especial Tributacao',
															items: const ['1=Microempresa Municipal','2=Estimativa','3=Sociedade de Profissionais','4=Cooperativa'],
															onChanged: (dynamic newValue) {
																nfseCabecalhoController.nfseCabecalhoModel.regimeEspecialTributacao = newValue;
																nfseCabecalhoController.formWasChanged = true;
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
															value: nfseCabecalhoController.nfseCabecalhoModel.optanteSimplesNacional ?? 'S',
															labelText: 'Optante Simples Nacional',
															hintText: 'Informe os dados para o campo Optante Simples Nacional',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																nfseCabecalhoController.nfseCabecalhoModel.optanteSimplesNacional = newValue;
																nfseCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfseCabecalhoController.nfseCabecalhoModel.incentivadorCultural ?? 'S',
															labelText: 'Incentivador Cultural',
															hintText: 'Informe os dados para o campo Incentivador Cultural',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																nfseCabecalhoController.nfseCabecalhoModel.incentivadorCultural = newValue;
																nfseCabecalhoController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfseCabecalhoController.numeroRpsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Rps',
																labelText: 'Numero Rps',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.numeroRps = text;
																nfseCabecalhoController.formWasChanged = true;
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
															maxLength: 5,
															controller: nfseCabecalhoController.serieRpsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie Rps',
																labelText: 'Serie Rps',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.serieRps = text;
																nfseCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfseCabecalhoController.nfseCabecalhoModel.tipoRps ?? '1=Recibo Provisório de Serviços',
															labelText: 'Tipo Rps',
															hintText: 'Informe os dados para o campo Tipo Rps',
															items: const ['1=Recibo Provisório de Serviços','2=RPS  Nota Fiscal Conjugada (Mista)','3=Cupom'],
															onChanged: (dynamic newValue) {
																nfseCabecalhoController.nfseCabecalhoModel.tipoRps = newValue;
																nfseCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Emissao Rps',
																labelText: 'Data Emissao Rps',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfseCabecalhoController.nfseCabecalhoModel.dataEmissaoRps,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfseCabecalhoController.nfseCabecalhoModel.dataEmissaoRps = value;
																	nfseCabecalhoController.formWasChanged = true;
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
															maxLines: 3,
															controller: nfseCabecalhoController.outrasInformacoesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outras Informacoes',
																labelText: 'Outras Informacoes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseCabecalhoController.nfseCabecalhoModel.outrasInformacoes = text;
																nfseCabecalhoController.formWasChanged = true;
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
