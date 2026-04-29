import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FeriasPeriodoAquisitivoModel {
	int? id;
	int? idColaborador;
	DateTime? dataInicio;
	DateTime? dataFim;
	String? situacao;
	DateTime? limiteParaGozo;
	String? descontarFaltas;
	String? desconsiderarAfastamento;
	int? afastamentoPrevidencia;
	int? afastamentoSemRemun;
	int? afastamentoComRemun;
	int? diasDireito;
	int? diasGozados;
	int? diasFaltas;
	int? diasRestantes;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FeriasPeriodoAquisitivoModel({
		this.id,
		this.idColaborador,
		this.dataInicio,
		this.dataFim,
		this.situacao,
		this.limiteParaGozo,
		this.descontarFaltas,
		this.desconsiderarAfastamento,
		this.afastamentoPrevidencia,
		this.afastamentoSemRemun,
		this.afastamentoComRemun,
		this.diasDireito,
		this.diasGozados,
		this.diasFaltas,
		this.diasRestantes,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'situacao',
		'limite_para_gozo',
		'descontar_faltas',
		'desconsiderar_afastamento',
		'afastamento_previdencia',
		'afastamento_sem_remun',
		'afastamento_com_remun',
		'dias_direito',
		'dias_gozados',
		'dias_faltas',
		'dias_restantes',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Situacao',
		'Limite Para Gozo',
		'Descontar Faltas',
		'Desconsiderar Afastamento',
		'Afastamento Previdencia',
		'Afastamento Sem Remun',
		'Afastamento Com Remun',
		'Dias Direito',
		'Dias Gozados',
		'Dias Faltas',
		'Dias Restantes',
	];

	FeriasPeriodoAquisitivoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		situacao = FeriasPeriodoAquisitivoDomain.getSituacao(jsonData['situacao']);
		limiteParaGozo = jsonData['limiteParaGozo'] != null ? DateTime.tryParse(jsonData['limiteParaGozo']) : null;
		descontarFaltas = FeriasPeriodoAquisitivoDomain.getDescontarFaltas(jsonData['descontarFaltas']);
		desconsiderarAfastamento = FeriasPeriodoAquisitivoDomain.getDesconsiderarAfastamento(jsonData['desconsiderarAfastamento']);
		afastamentoPrevidencia = jsonData['afastamentoPrevidencia'];
		afastamentoSemRemun = jsonData['afastamentoSemRemun'];
		afastamentoComRemun = jsonData['afastamentoComRemun'];
		diasDireito = jsonData['diasDireito'];
		diasGozados = jsonData['diasGozados'];
		diasFaltas = jsonData['diasFaltas'];
		diasRestantes = jsonData['diasRestantes'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['situacao'] = FeriasPeriodoAquisitivoDomain.setSituacao(situacao);
		jsonData['limiteParaGozo'] = limiteParaGozo != null ? DateFormat('yyyy-MM-ddT00:00:00').format(limiteParaGozo!) : null;
		jsonData['descontarFaltas'] = FeriasPeriodoAquisitivoDomain.setDescontarFaltas(descontarFaltas);
		jsonData['desconsiderarAfastamento'] = FeriasPeriodoAquisitivoDomain.setDesconsiderarAfastamento(desconsiderarAfastamento);
		jsonData['afastamentoPrevidencia'] = afastamentoPrevidencia;
		jsonData['afastamentoSemRemun'] = afastamentoSemRemun;
		jsonData['afastamentoComRemun'] = afastamentoComRemun;
		jsonData['diasDireito'] = diasDireito;
		jsonData['diasGozados'] = diasGozados;
		jsonData['diasFaltas'] = diasFaltas;
		jsonData['diasRestantes'] = diasRestantes;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : '0=Em Aberto';
		limiteParaGozo = Util.stringToDate(plutoRow.cells['limiteParaGozo']?.value);
		descontarFaltas = plutoRow.cells['descontarFaltas']?.value != '' ? plutoRow.cells['descontarFaltas']?.value : 'Sim';
		desconsiderarAfastamento = plutoRow.cells['desconsiderarAfastamento']?.value != '' ? plutoRow.cells['desconsiderarAfastamento']?.value : 'Sim';
		afastamentoPrevidencia = plutoRow.cells['afastamentoPrevidencia']?.value;
		afastamentoSemRemun = plutoRow.cells['afastamentoSemRemun']?.value;
		afastamentoComRemun = plutoRow.cells['afastamentoComRemun']?.value;
		diasDireito = plutoRow.cells['diasDireito']?.value;
		diasGozados = plutoRow.cells['diasGozados']?.value;
		diasFaltas = plutoRow.cells['diasFaltas']?.value;
		diasRestantes = plutoRow.cells['diasRestantes']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FeriasPeriodoAquisitivoModel clone() {
		return FeriasPeriodoAquisitivoModel(
			id: id,
			idColaborador: idColaborador,
			dataInicio: dataInicio,
			dataFim: dataFim,
			situacao: situacao,
			limiteParaGozo: limiteParaGozo,
			descontarFaltas: descontarFaltas,
			desconsiderarAfastamento: desconsiderarAfastamento,
			afastamentoPrevidencia: afastamentoPrevidencia,
			afastamentoSemRemun: afastamentoSemRemun,
			afastamentoComRemun: afastamentoComRemun,
			diasDireito: diasDireito,
			diasGozados: diasGozados,
			diasFaltas: diasFaltas,
			diasRestantes: diasRestantes,
		);			
	}

	
}