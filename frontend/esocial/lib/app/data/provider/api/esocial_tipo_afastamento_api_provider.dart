import 'dart:convert';
import 'package:esocial/app/data/provider/api/api_provider_base.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialTipoAfastamentoApiProvider extends ApiProviderBase {

	Future<List<EsocialTipoAfastamentoModel>?> getList({Filter? filter}) async {
		List<EsocialTipoAfastamentoModel> esocialTipoAfastamentoModelList = [];

		try {
			handleFilter(filter, '/esocial-tipo-afastamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialTipoAfastamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var esocialTipoAfastamentoModel in esocialTipoAfastamentoModelJson) {
						esocialTipoAfastamentoModelList.add(EsocialTipoAfastamentoModel.fromJson(esocialTipoAfastamentoModel));
					}
					return esocialTipoAfastamentoModelList;
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

	Future<EsocialTipoAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/esocial-tipo-afastamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialTipoAfastamentoModelJson = json.decode(response.body);
					return EsocialTipoAfastamentoModel.fromJson(esocialTipoAfastamentoModelJson);		 
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

	Future<EsocialTipoAfastamentoModel?>? insert(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/esocial-tipo-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialTipoAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialTipoAfastamentoModelJson = json.decode(response.body);
					return EsocialTipoAfastamentoModel.fromJson(esocialTipoAfastamentoModelJson);
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

	Future<EsocialTipoAfastamentoModel?>? update(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/esocial-tipo-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: esocialTipoAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var esocialTipoAfastamentoModelJson = json.decode(response.body);
					return EsocialTipoAfastamentoModel.fromJson(esocialTipoAfastamentoModelJson);
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
				Uri.tryParse('$endpoint/esocial-tipo-afastamento/$pk')!,
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
