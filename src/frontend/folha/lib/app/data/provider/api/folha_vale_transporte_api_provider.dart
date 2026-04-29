import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaValeTransporteApiProvider extends ApiProviderBase {

	Future<List<FolhaValeTransporteModel>?> getList({Filter? filter}) async {
		List<FolhaValeTransporteModel> folhaValeTransporteModelList = [];

		try {
			handleFilter(filter, '/folha-vale-transporte/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaValeTransporteModelJson = json.decode(response.body) as List<dynamic>;
					for (var folhaValeTransporteModel in folhaValeTransporteModelJson) {
						folhaValeTransporteModelList.add(FolhaValeTransporteModel.fromJson(folhaValeTransporteModel));
					}
					return folhaValeTransporteModelList;
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

	Future<FolhaValeTransporteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/folha-vale-transporte/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaValeTransporteModelJson = json.decode(response.body);
					return FolhaValeTransporteModel.fromJson(folhaValeTransporteModelJson);		 
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

	Future<FolhaValeTransporteModel?>? insert(FolhaValeTransporteModel folhaValeTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/folha-vale-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaValeTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaValeTransporteModelJson = json.decode(response.body);
					return FolhaValeTransporteModel.fromJson(folhaValeTransporteModelJson);
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

	Future<FolhaValeTransporteModel?>? update(FolhaValeTransporteModel folhaValeTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/folha-vale-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: folhaValeTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var folhaValeTransporteModelJson = json.decode(response.body);
					return FolhaValeTransporteModel.fromJson(folhaValeTransporteModelJson);
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
				Uri.tryParse('$endpoint/folha-vale-transporte/$pk')!,
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
