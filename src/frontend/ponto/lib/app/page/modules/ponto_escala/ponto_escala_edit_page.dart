import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_escala_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoEscalaEditPage extends StatelessWidget {
	PontoEscalaEditPage({Key? key}) : super(key: key);
	final pontoEscalaController = Get.find<PontoEscalaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pontoEscalaController.pontoEscalaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoEscalaController.pontoEscalaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoEscalaController.scrollController,
							child: SingleChildScrollView(
								controller: pontoEscalaController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: pontoEscalaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.nome = text;
																pontoEscalaController.formWasChanged = true;
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
															controller: pontoEscalaController.descontoHoraDiaController,
															decoration: inputDecoration(
																hintText: 'Número de horas que serão descontadas do funcionário caso perca um dia',
																labelText: 'Desconto Hora Dia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.descontoHoraDia = text;
																pontoEscalaController.formWasChanged = true;
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
															controller: pontoEscalaController.descontoDsrController,
															decoration: inputDecoration(
																hintText: 'Número de horas que devem ser descontadas do descanso semanal remunerado, caso haja uma falta',
																labelText: 'Desconto Semanal Remunerado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.descontoDsr = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioDomingoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Domingo',
																labelText: 'Codigo Horario Domingo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioDomingo = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioSegundaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Segunda',
																labelText: 'Codigo Horario Segunda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioSegunda = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioTercaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Terca',
																labelText: 'Codigo Horario Terca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioTerca = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioQuartaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Quarta',
																labelText: 'Codigo Horario Quarta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioQuarta = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioQuintaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Quinta',
																labelText: 'Codigo Horario Quinta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioQuinta = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioSextaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Sexta',
																labelText: 'Codigo Horario Sexta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioSexta = text;
																pontoEscalaController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoEscalaController.codigoHorarioSabadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario Sabado',
																labelText: 'Codigo Horario Sabado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoEscalaController.pontoEscalaModel.codigoHorarioSabado = text;
																pontoEscalaController.formWasChanged = true;
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
