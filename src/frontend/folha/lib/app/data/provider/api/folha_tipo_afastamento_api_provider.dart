import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaTipoAfastamentoApiProvider extends ApiProviderBase {

	Future<List<FolhaTipoAfastamentoModel>?> getList({Filter? filter}) async {
		List<FolhaTipoAfastamentoModel> folhaTipoAfastamentoModelList = [];

		try {
			handleFilter(filter, '/folha-tipo-afastamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaTipoAfastamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaTipoAfastamentoModel in folhaTipoAfastamentoModelJson) {
						folhaTipoAfastamentoModelList.add(FolhaTipoAfastamentoModel.fromJson(folhaTipoAfastamentoModel));
					}
					return folhaTipoAfastamentoModelList;
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

	Future<FolhaTipoAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-tipo-afastamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaTipoAfastamentoModelJson = json.decode(response.body);
					return FolhaTipoAfastamentoModel.fromJson(folhaTipoAfastamentoModelJson);		 
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

	Future<FolhaTipoAfastamentoModel?>? insert(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-tipo-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaTipoAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaTipoAfastamentoModelJson = json.decode(response.body);
					return FolhaTipoAfastamentoModel.fromJson(folhaTipoAfastamentoModelJson);
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

	Future<FolhaTipoAfastamentoModel?>? update(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-tipo-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaTipoAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaTipoAfastamentoModelJson = json.decode(response.body);
					return FolhaTipoAfastamentoModel.fromJson(folhaTipoAfastamentoModelJson);
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
				Uri.tryParse('$endpoint/folha-tipo-afastamento/$pk')!,
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
