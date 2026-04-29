import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_parametro_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilParametroEditPage extends StatelessWidget {
	ContabilParametroEditPage({Key? key}) : super(key: key);
	final contabilParametroController = Get.find<ContabilParametroController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					contabilParametroController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: contabilParametroController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parâmetros - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilParametroController.save),
						cancelAndExitButton(onPressed: contabilParametroController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilParametroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilParametroController.scrollController,
							child: SingleChildScrollView(
								controller: contabilParametroController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: contabilParametroController.mascaraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mascara',
																labelText: 'Mascara',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.mascara = text;
																contabilParametroController.formWasChanged = true;
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
															controller: contabilParametroController.niveisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Niveis',
																labelText: 'Niveis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.niveis = int.tryParse(text);
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.informarContaPor ?? 'Código',
															labelText: 'Informar Conta Por',
															hintText: 'Informe os dados para o campo Informar Conta Por',
															items: const ['Código','Máscara'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.informarContaPor = newValue;
																contabilParametroController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.compartilhaPlanoConta ?? 'Sim',
															labelText: 'Compartilha Plano Conta',
															hintText: 'Informe os dados para o campo Compartilha Plano Conta',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.compartilhaPlanoConta = newValue;
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.compartilhaHistoricos ?? 'Sim',
															labelText: 'Compartilha Historicos',
															hintText: 'Informe os dados para o campo Compartilha Historicos',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.compartilhaHistoricos = newValue;
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.alteraLancamentoOutro ?? 'Sim',
															labelText: 'Altera Lancamento Outro',
															hintText: 'Informe os dados para o campo Altera Lancamento Outro',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.alteraLancamentoOutro = newValue;
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.historicoObrigatorio ?? 'Sim',
															labelText: 'Historico Obrigatorio',
															hintText: 'Informe os dados para o campo Historico Obrigatorio',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.historicoObrigatorio = newValue;
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.permiteLancamentoZerado ?? 'Sim',
															labelText: 'Permite Lancamento Zerado',
															hintText: 'Informe os dados para o campo Permite Lancamento Zerado',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.permiteLancamentoZerado = newValue;
																contabilParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.geraInformativoSped ?? 'Sim',
															labelText: 'Gera Informativo Sped',
															hintText: 'Informe os dados para o campo Gera Informativo Sped',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.geraInformativoSped = newValue;
																contabilParametroController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: contabilParametroController.contabilParametroModel.spedFormaEscritDiario ?? 'Livro Diário Completo',
															labelText: 'Sped Forma Escrit Diario',
															hintText: 'Informe os dados para o campo Sped Forma Escrit Diario',
															items: const ['Livro Diário Completo','Livro Diário com Escrituração Resumida','Livro Balancete Diário e Balanços'],
															onChanged: (dynamic newValue) {
																contabilParametroController.contabilParametroModel.spedFormaEscritDiario = newValue;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 100,
															controller: contabilParametroController.spedNomeLivroDiarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sped Nome Livro Diario',
																labelText: 'Sped Nome Livro Diario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.spedNomeLivroDiario = text;
																contabilParametroController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLines: 3,
															controller: contabilParametroController.assinaturaDireitaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Assinatura Direita',
																labelText: 'Assinatura Direita',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.assinaturaDireita = text;
																contabilParametroController.formWasChanged = true;
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
															maxLines: 3,
															controller: contabilParametroController.assinaturaEsquerdaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Assinatura Esquerda',
																labelText: 'Assinatura Esquerda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.assinaturaEsquerda = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaAtivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Ativo',
																labelText: 'Conta Ativo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaAtivo = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaPassivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Passivo',
																labelText: 'Conta Passivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaPassivo = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaPatrimonioLiquidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Patrimonio Liquido',
																labelText: 'Conta Patrimonio Liquido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaPatrimonioLiquido = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaDepreciacaoAcumuladaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Depreciacao Acumulada',
																labelText: 'Conta Depreciacao Acumulada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaDepreciacaoAcumulada = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaCapitalSocialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Capital Social',
																labelText: 'Conta Capital Social',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaCapitalSocial = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaResultadoExercicioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Resultado Exercicio',
																labelText: 'Conta Resultado Exercicio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaResultadoExercicio = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaPrejuizoAcumuladoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Prejuizo Acumulado',
																labelText: 'Conta Prejuizo Acumulado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaPrejuizoAcumulado = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaLucroAcumuladoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Lucro Acumulado',
																labelText: 'Conta Lucro Acumulado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaLucroAcumulado = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaTituloPagarController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Titulo Pagar',
																labelText: 'Conta Titulo Pagar',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaTituloPagar = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaTituloReceberController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Titulo Receber',
																labelText: 'Conta Titulo Receber',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaTituloReceber = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaJurosPassivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Juros Passivo',
																labelText: 'Conta Juros Passivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaJurosPassivo = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaJurosAtivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Juros Ativo',
																labelText: 'Conta Juros Ativo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaJurosAtivo = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaDescontoObtidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Desconto Obtido',
																labelText: 'Conta Desconto Obtido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaDescontoObtido = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaDescontoConcedidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Desconto Concedido',
																labelText: 'Conta Desconto Concedido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaDescontoConcedido = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaCmvController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Cmv',
																labelText: 'Conta Cmv',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaCmv = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaVendaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Venda',
																labelText: 'Conta Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaVenda = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaVendaServicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Venda Servico',
																labelText: 'Conta Venda Servico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaVendaServico = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaEstoqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Estoque',
																labelText: 'Conta Estoque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaEstoque = text;
																contabilParametroController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: contabilParametroController.contaApuraResultadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Apura Resultado',
																labelText: 'Conta Apura Resultado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaApuraResultado = text;
																contabilParametroController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilParametroController.contaJurosApropriarController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Juros Apropriar',
																labelText: 'Conta Juros Apropriar',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.contaJurosApropriar = text;
																contabilParametroController.formWasChanged = true;
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
															controller: contabilParametroController.idHistPadraoResultadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Hist Padrao Resultado',
																labelText: 'Id Hist Padrao Resultado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.idHistPadraoResultado = int.tryParse(text);
																contabilParametroController.formWasChanged = true;
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
															controller: contabilParametroController.idHistPadraoLucroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Hist Padrao Lucro',
																labelText: 'Id Hist Padrao Lucro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.idHistPadraoLucro = int.tryParse(text);
																contabilParametroController.formWasChanged = true;
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
															controller: contabilParametroController.idHistPadraoPrejuizoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Hist Padrao Prejuizo',
																labelText: 'Id Hist Padrao Prejuizo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilParametroController.contabilParametroModel.idHistPadraoPrejuizo = int.tryParse(text);
																contabilParametroController.formWasChanged = true;
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
