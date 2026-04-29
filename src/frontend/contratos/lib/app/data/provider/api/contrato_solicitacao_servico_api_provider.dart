import 'dart:convert';
import 'package:contratos/app/data/provider/api/api_provider_base.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoSolicitacaoServicoApiProvider extends ApiProviderBase {

	Future<List<ContratoSolicitacaoServicoModel>?> getList({Filter? filter}) async {
		List<ContratoSolicitacaoServicoModel> contratoSolicitacaoServicoModelList = [];

		try {
			handleFilter(filter, '/contrato-solicitacao-servico/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoSolicitacaoServicoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contratoSolicitacaoServicoModel in contratoSolicitacaoServicoModelJson) {
						contratoSolicitacaoServicoModelList.add(ContratoSolicitacaoServicoModel.fromJson(contratoSolicitacaoServicoModel));
					}
					return contratoSolicitacaoServicoModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContratoSolicitacaoServicoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contrato-solicitacao-servico/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoSolicitacaoServicoModelJson = json.decode(response.body);
					return ContratoSolicitacaoServicoModel.fromJson(contratoSolicitacaoServicoModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoSolicitacaoServicoModel?>? insert(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contrato-solicitacao-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoSolicitacaoServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoSolicitacaoServicoModelJson = json.decode(response.body);
					return ContratoSolicitacaoServicoModel.fromJson(contratoSolicitacaoServicoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoSolicitacaoServicoModel?>? update(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contrato-solicitacao-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoSolicitacaoServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoSolicitacaoServicoModelJson = json.decode(response.body);
					return ContratoSolicitacaoServicoModel.fromJson(contratoSolicitacaoServicoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.delete(
				Uri.tryParse('$endpoint/contrato-solicitacao-servico/$pk')!,
				headers: ApiProviderBase.headerRequisition(),
			);

			if (response.statusCode == 200) {
				return true;
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	
}
