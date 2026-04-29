import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/controller/orcamento_fluxo_caixa_periodo_controller.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/page/shared_widget/input/input_imports.dart';

class OrcamentoFluxoCaixaPeriodoEditPage extends StatelessWidget {
	OrcamentoFluxoCaixaPeriodoEditPage({Key? key}) : super(key: key);
	final orcamentoFluxoCaixaPeriodoController = Get.find<OrcamentoFluxoCaixaPeriodoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					orcamentoFluxoCaixaPeriodoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: orcamentoFluxoCaixaPeriodoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Períodos - Fluxo de Caixa - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: orcamentoFluxoCaixaPeriodoController.save),
						cancelAndExitButton(onPressed: orcamentoFluxoCaixaPeriodoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: orcamentoFluxoCaixaPeriodoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: orcamentoFluxoCaixaPeriodoController.scrollController,
							child: SingleChildScrollView(
								controller: orcamentoFluxoCaixaPeriodoController.scrollController,
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
																		controller: orcamentoFluxoCaixaPeriodoController.bancoContaCaixaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta/Caixa',
																			labelText: 'Conta/Caixa *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: orcamentoFluxoCaixaPeriodoController.callBancoContaCaixaLookup),
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
														child: CustomDropdownButtonFormField(
															value: orcamentoFluxoCaixaPeriodoController.orcamentoFluxoCaixaPeriodoModel.periodo ?? '01=Diário',
															labelText: 'Periodo',
															hintText: 'Informe os dados para o campo Periodo',
															items: const ['01=Diário','02=Semanal','03=Mensal','04=Bimestral','05=Trimestral','06=Semestral','07=Anual'],
															onChanged: (dynamic newValue) {
																orcamentoFluxoCaixaPeriodoController.orcamentoFluxoCaixaPeriodoModel.periodo = newValue;
																orcamentoFluxoCaixaPeriodoController.formWasChanged = true;
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
															maxLength: 30,
															controller: orcamentoFluxoCaixaPeriodoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoFluxoCaixaPeriodoController.orcamentoFluxoCaixaPeriodoModel.nome = text;
																orcamentoFluxoCaixaPeriodoController.formWasChanged = true;
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
