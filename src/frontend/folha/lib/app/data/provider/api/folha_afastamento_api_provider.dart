import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaAfastamentoApiProvider extends ApiProviderBase {

	Future<List<FolhaAfastamentoModel>?> getList({Filter? filter}) async {
		List<FolhaAfastamentoModel> folhaAfastamentoModelList = [];

		try {
			handleFilter(filter, '/folha-afastamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaAfastamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaAfastamentoModel in folhaAfastamentoModelJson) {
						folhaAfastamentoModelList.add(FolhaAfastamentoModel.fromJson(folhaAfastamentoModel));
					}
					return folhaAfastamentoModelList;
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

	Future<FolhaAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-afastamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaAfastamentoModelJson = json.decode(response.body);
					return FolhaAfastamentoModel.fromJson(folhaAfastamentoModelJson);		 
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

	Future<FolhaAfastamentoModel?>? insert(FolhaAfastamentoModel folhaAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaAfastamentoModelJson = json.decode(response.body);
					return FolhaAfastamentoModel.fromJson(folhaAfastamentoModelJson);
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

	Future<FolhaAfastamentoModel?>? update(FolhaAfastamentoModel folhaAfastamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-afastamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaAfastamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaAfastamentoModelJson = json.decode(response.body);
					return FolhaAfastamentoModel.fromJson(folhaAfastamentoModelJson);
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
				Uri.tryParse('$endpoint/folha-afastamento/$pk')!,
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
