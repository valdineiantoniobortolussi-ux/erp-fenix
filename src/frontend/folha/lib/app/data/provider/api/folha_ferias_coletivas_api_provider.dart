import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFeriasColetivasApiProvider extends ApiProviderBase {

	Future<List<FolhaFeriasColetivasModel>?> getList({Filter? filter}) async {
		List<FolhaFeriasColetivasModel> folhaFeriasColetivasModelList = [];

		try {
			handleFilter(filter, '/folha-ferias-coletivas/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFeriasColetivasModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaFeriasColetivasModel in folhaFeriasColetivasModelJson) {
						folhaFeriasColetivasModelList.add(FolhaFeriasColetivasModel.fromJson(folhaFeriasColetivasModel));
					}
					return folhaFeriasColetivasModelList;
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

	Future<FolhaFeriasColetivasModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-ferias-coletivas/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFeriasColetivasModelJson = json.decode(response.body);
					return FolhaFeriasColetivasModel.fromJson(folhaFeriasColetivasModelJson);		 
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

	Future<FolhaFeriasColetivasModel?>? insert(FolhaFeriasColetivasModel folhaFeriasColetivasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-ferias-coletivas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaFeriasColetivasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFeriasColetivasModelJson = json.decode(response.body);
					return FolhaFeriasColetivasModel.fromJson(folhaFeriasColetivasModelJson);
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

	Future<FolhaFeriasColetivasModel?>? update(FolhaFeriasColetivasModel folhaFeriasColetivasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-ferias-coletivas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaFeriasColetivasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaFeriasColetivasModelJson = json.decode(response.body);
					return FolhaFeriasColetivasModel.fromJson(folhaFeriasColetivasModelJson);
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
				Uri.tryParse('$endpoint/folha-ferias-coletivas/$pk')!,
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
