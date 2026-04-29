import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilTermoModel {
	int? id;
	int? idContabilLivro;
	String? aberturaEncerramento;
	int? numero;
	int? paginaInicial;
	int? paginaFinal;
	String? registrado;
	String? numeroRegistro;
	DateTime? dataDespacho;
	DateTime? dataAbertura;
	DateTime? dataEncerramento;
	DateTime? escrituracaoInicio;
	DateTime? escrituracaoFim;
	String? texto;

	ContabilTermoModel({
		this.id,
		this.idContabilLivro,
		this.aberturaEncerramento,
		this.numero,
		this.paginaInicial,
		this.paginaFinal,
		this.registrado,
		this.numeroRegistro,
		this.dataDespacho,
		this.dataAbertura,
		this.dataEncerramento,
		this.escrituracaoInicio,
		this.escrituracaoFim,
		this.texto,
	});

	static List<String> dbColumns = <String>[
		'id',
		'abertura_encerramento',
		'numero',
		'pagina_inicial',
		'pagina_final',
		'registrado',
		'numero_registro',
		'data_despacho',
		'data_abertura',
		'data_encerramento',
		'escrituracao_inicio',
		'escrituracao_fim',
		'texto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Abertura Encerramento',
		'Numero',
		'Pagina Inicial',
		'Pagina Final',
		'Registrado',
		'Numero Registro',
		'Data Despacho',
		'Data Abertura',
		'Data Encerramento',
		'Escrituracao Inicio',
		'Escrituracao Fim',
		'Texto',
	];

	ContabilTermoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilLivro = jsonData['idContabilLivro'];
		aberturaEncerramento = ContabilTermoDomain.getAberturaEncerramento(jsonData['aberturaEncerramento']);
		numero = jsonData['numero'];
		paginaInicial = jsonData['paginaInicial'];
		paginaFinal = jsonData['paginaFinal'];
		registrado = jsonData['registrado'];
		numeroRegistro = jsonData['numeroRegistro'];
		dataDespacho = jsonData['dataDespacho'] != null ? DateTime.tryParse(jsonData['dataDespacho']) : null;
		dataAbertura = jsonData['dataAbertura'] != null ? DateTime.tryParse(jsonData['dataAbertura']) : null;
		dataEncerramento = jsonData['dataEncerramento'] != null ? DateTime.tryParse(jsonData['dataEncerramento']) : null;
		escrituracaoInicio = jsonData['escrituracaoInicio'] != null ? DateTime.tryParse(jsonData['escrituracaoInicio']) : null;
		escrituracaoFim = jsonData['escrituracaoFim'] != null ? DateTime.tryParse(jsonData['escrituracaoFim']) : null;
		texto = jsonData['texto'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilLivro'] = idContabilLivro != 0 ? idContabilLivro : null;
		jsonData['aberturaEncerramento'] = ContabilTermoDomain.setAberturaEncerramento(aberturaEncerramento);
		jsonData['numero'] = numero;
		jsonData['paginaInicial'] = paginaInicial;
		jsonData['paginaFinal'] = paginaFinal;
		jsonData['registrado'] = registrado;
		jsonData['numeroRegistro'] = numeroRegistro;
		jsonData['dataDespacho'] = dataDespacho != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDespacho!) : null;
		jsonData['dataAbertura'] = dataAbertura != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAbertura!) : null;
		jsonData['dataEncerramento'] = dataEncerramento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEncerramento!) : null;
		jsonData['escrituracaoInicio'] = escrituracaoInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(escrituracaoInicio!) : null;
		jsonData['escrituracaoFim'] = escrituracaoFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(escrituracaoFim!) : null;
		jsonData['texto'] = texto;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilLivro = plutoRow.cells['idContabilLivro']?.value;
		aberturaEncerramento = plutoRow.cells['aberturaEncerramento']?.value != '' ? plutoRow.cells['aberturaEncerramento']?.value : 'Abertura';
		numero = plutoRow.cells['numero']?.value;
		paginaInicial = plutoRow.cells['paginaInicial']?.value;
		paginaFinal = plutoRow.cells['paginaFinal']?.value;
		registrado = plutoRow.cells['registrado']?.value;
		numeroRegistro = plutoRow.cells['numeroRegistro']?.value;
		dataDespacho = Util.stringToDate(plutoRow.cells['dataDespacho']?.value);
		dataAbertura = Util.stringToDate(plutoRow.cells['dataAbertura']?.value);
		dataEncerramento = Util.stringToDate(plutoRow.cells['dataEncerramento']?.value);
		escrituracaoInicio = Util.stringToDate(plutoRow.cells['escrituracaoInicio']?.value);
		escrituracaoFim = Util.stringToDate(plutoRow.cells['escrituracaoFim']?.value);
		texto = plutoRow.cells['texto']?.value;
	}	

	ContabilTermoModel clone() {
		return ContabilTermoModel(
			id: id,
			idContabilLivro: idContabilLivro,
			aberturaEncerramento: aberturaEncerramento,
			numero: numero,
			paginaInicial: paginaInicial,
			paginaFinal: paginaFinal,
			registrado: registrado,
			numeroRegistro: numeroRegistro,
			dataDespacho: dataDespacho,
			dataAbertura: dataAbertura,
			dataEncerramento: dataEncerramento,
			escrituracaoInicio: escrituracaoInicio,
			escrituracaoFim: escrituracaoFim,
			texto: texto,
		);			
	}

	
}