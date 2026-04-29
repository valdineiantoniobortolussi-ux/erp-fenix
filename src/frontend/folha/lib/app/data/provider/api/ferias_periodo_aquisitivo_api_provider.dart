import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FeriasPeriodoAquisitivoApiProvider extends ApiProviderBase {

	Future<List<FeriasPeriodoAquisitivoModel>?> getList({Filter? filter}) async {
		List<FeriasPeriodoAquisitivoModel> feriasPeriodoAquisitivoModelList = [];

		try {
			handleFilter(filter, '/ferias-periodo-aquisitivo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var feriasPeriodoAquisitivoModelJson = json.decode(response.body) as List<dynamic>;
					for (var feriasPeriodoAquisitivoModel in feriasPeriodoAquisitivoModelJson) {
						feriasPeriodoAquisitivoModelList.add(FeriasPeriodoAquisitivoModel.fromJson(feriasPeriodoAquisitivoModel));
					}
					return feriasPeriodoAquisitivoModelList;
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

	Future<FeriasPeriodoAquisitivoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ferias-periodo-aquisitivo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var feriasPeriodoAquisitivoModelJson = json.decode(response.body);
					return FeriasPeriodoAquisitivoModel.fromJson(feriasPeriodoAquisitivoModelJson);		 
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

	Future<FeriasPeriodoAquisitivoModel?>? insert(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ferias-periodo-aquisitivo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: feriasPeriodoAquisitivoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var feriasPeriodoAquisitivoModelJson = json.decode(response.body);
					return FeriasPeriodoAquisitivoModel.fromJson(feriasPeriodoAquisitivoModelJson);
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

	Future<FeriasPeriodoAquisitivoModel?>? update(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ferias-periodo-aquisitivo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: feriasPeriodoAquisitivoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var feriasPeriodoAquisitivoModelJson = json.decode(response.body);
					return FeriasPeriodoAquisitivoModel.fromJson(feriasPeriodoAquisitivoModelJson);
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
				Uri.tryParse('$endpoint/ferias-periodo-aquisitivo/$pk')!,
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
