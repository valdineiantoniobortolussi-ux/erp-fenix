import 'dart:convert';
import 'package:esocial/app/data/provider/api/api_provider_base.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialMotivoDesligamentoApiProvider extends ApiProviderBase {

	Future<List<EsocialMotivoDesligamentoModel>?> getList({Filter? filter}) async {
		List<EsocialMotivoDesligamentoModel> esocialMotivoDesligamentoModelList = [];

		try {
			handleFilter(filter, '/esocial-motivo-desligamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialMotivoDesligamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var esocialMotivoDesligamentoModel in esocialMotivoDesligamentoModelJson) {
						esocialMotivoDesligamentoModelList.add(EsocialMotivoDesligamentoModel.fromJson(esocialMotivoDesligamentoModel));
					}
					return esocialMotivoDesligamentoModelList;
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

	Future<EsocialMotivoDesligamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/esocial-motivo-desligamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialMotivoDesligamentoModelJson = json.decode(response.body);
					return EsocialMotivoDesligamentoModel.fromJson(esocialMotivoDesligamentoModelJson);		 
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

	Future<EsocialMotivoDesligamentoModel?>? insert(EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/esocial-motivo-desligamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialMotivoDesligamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialMotivoDesligamentoModelJson = json.decode(response.body);
					return EsocialMotivoDesligamentoModel.fromJson(esocialMotivoDesligamentoModelJson);
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

	Future<EsocialMotivoDesligamentoModel?>? update(EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/esocial-motivo-desligamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialMotivoDesligamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialMotivoDesligamentoModelJson = json.decode(response.body);
					return EsocialMotivoDesligamentoModel.fromJson(esocialMotivoDesligamentoModelJson);
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
				Uri.tryParse('$endpoint/esocial-motivo-desligamento/$pk')!,
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
