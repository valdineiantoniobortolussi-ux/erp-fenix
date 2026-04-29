import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioPedagioModel {
	int? id;
	int? idMdfeRodoviario;
	String? cnpjFornecedor;
	String? cnpjResponsavel;
	String? cpfResponsavel;
	String? numeroComprovante;
	double? valor;
	MdfeRodoviarioModel? mdfeRodoviarioModel;

	MdfeRodoviarioPedagioModel({
		this.id,
		this.idMdfeRodoviario,
		this.cnpjFornecedor,
		this.cnpjResponsavel,
		this.cpfResponsavel,
		this.numeroComprovante,
		this.valor,
		this.mdfeRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj_fornecedor',
		'cnpj_responsavel',
		'cpf_responsavel',
		'numero_comprovante',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj Fornecedor',
		'Cnpj Responsavel',
		'Cpf Responsavel',
		'Numero Comprovante',
		'Valor',
	];

	MdfeRodoviarioPedagioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeRodoviario = jsonData['idMdfeRodoviario'];
		cnpjFornecedor = jsonData['cnpjFornecedor'];
		cnpjResponsavel = jsonData['cnpjResponsavel'];
		cpfResponsavel = jsonData['cpfResponsavel'];
		numeroComprovante = jsonData['numeroComprovante'];
		valor = jsonData['valor']?.toDouble();
		mdfeRodoviarioModel = jsonData['mdfeRodoviarioModel'] == null ? MdfeRodoviarioModel() : MdfeRodoviarioModel.fromJson(jsonData['mdfeRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeRodoviario'] = idMdfeRodoviario != 0 ? idMdfeRodoviario : null;
		jsonData['cnpjFornecedor'] = Util.removeMask(cnpjFornecedor);
		jsonData['cnpjResponsavel'] = Util.removeMask(cnpjResponsavel);
		jsonData['cpfResponsavel'] = Util.removeMask(cpfResponsavel);
		jsonData['numeroComprovante'] = numeroComprovante;
		jsonData['valor'] = valor;
		jsonData['mdfeRodoviarioModel'] = mdfeRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeRodoviario = plutoRow.cells['idMdfeRodoviario']?.value;
		cnpjFornecedor = plutoRow.cells['cnpjFornecedor']?.value;
		cnpjResponsavel = plutoRow.cells['cnpjResponsavel']?.value;
		cpfResponsavel = plutoRow.cells['cpfResponsavel']?.value;
		numeroComprovante = plutoRow.cells['numeroComprovante']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		mdfeRodoviarioModel = MdfeRodoviarioModel();
		mdfeRodoviarioModel?.codigoAgendamento = plutoRow.cells['mdfeRodoviarioModel']?.value;
	}	

	MdfeRodoviarioPedagioModel clone() {
		return MdfeRodoviarioPedagioModel(
			id: id,
			idMdfeRodoviario: idMdfeRodoviario,
			cnpjFornecedor: cnpjFornecedor,
			cnpjResponsavel: cnpjResponsavel,
			cpfResponsavel: cpfResponsavel,
			numeroComprovante: numeroComprovante,
			valor: valor,
		);			
	}

	
}