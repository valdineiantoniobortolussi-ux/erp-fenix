import 'dart:convert';
import 'package:folha/app/data/provider/api/api_provider_base.dart';
import 'package:folha/app/data/model/model_imports.dart';

class GuiasAcumuladasApiProvider extends ApiProviderBase {

	Future<List<GuiasAcumuladasModel>?> getList({Filter? filter}) async {
		List<GuiasAcumuladasModel> guiasAcumuladasModelList = [];

		try {
			handleFilter(filter, '/guias-acumuladas/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var guiasAcumuladasModelJson = json.decode(response.body) as List<dynamic>;
					for (var guiasAcumuladasModel in guiasAcumuladasModelJson) {
						guiasAcumuladasModelList.add(GuiasAcumuladasModel.fromJson(guiasAcumuladasModel));
					}
					return guiasAcumuladasModelList;
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

	Future<GuiasAcumuladasModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/guias-acumuladas/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var guiasAcumuladasModelJson = json.decode(response.body);
					return GuiasAcumuladasModel.fromJson(guiasAcumuladasModelJson);		 
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

	Future<GuiasAcumuladasModel?>? insert(GuiasAcumuladasModel guiasAcumuladasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/guias-acumuladas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: guiasAcumuladasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var guiasAcumuladasModelJson = json.decode(response.body);
					return GuiasAcumuladasModel.fromJson(guiasAcumuladasModelJson);
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

	Future<GuiasAcumuladasModel?>? update(GuiasAcumuladasModel guiasAcumuladasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/guias-acumuladas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: guiasAcumuladasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var guiasAcumuladasModelJson = json.decode(response.body);
					return GuiasAcumuladasModel.fromJson(guiasAcumuladasModelJson);
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
				Uri.tryParse('$endpoint/guias-acumuladas/$pk')!,
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
