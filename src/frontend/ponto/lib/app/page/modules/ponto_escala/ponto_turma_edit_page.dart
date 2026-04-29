import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_turma_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoTurmaEditPage extends StatelessWidget {
	PontoTurmaEditPage({Key? key}) : super(key: key);
	final pontoTurmaController = Get.find<PontoTurmaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pontoTurmaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Turmas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoTurmaController.save),
						cancelAndExitButton(onPressed: pontoTurmaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoTurmaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoTurmaController.scrollController,
							child: SingleChildScrollView(
								controller: pontoTurmaController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 5,
															controller: pontoTurmaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoTurmaController.pontoTurmaModel.codigo = text;
																pontoTurmaController.formWasChanged = true;
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
															maxLength: 50,
															controller: pontoTurmaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoTurmaController.pontoTurmaModel.nome = text;
																pontoTurmaController.formWasChanged = true;
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
