import 'dart:convert';
import 'package:cadastros/app/data/provider/api/api_provider_base.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorTipoApiProvider extends ApiProviderBase {

	Future<List<ColaboradorTipoModel>?> getList({Filter? filter}) async {
		List<ColaboradorTipoModel> colaboradorTipoModelList = [];

		try {
			handleFilter(filter, '/colaborador-tipo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorTipoModelJson = json.decode(response.body) as List<dynamic>;
					for (var colaboradorTipoModel in colaboradorTipoModelJson) {
						colaboradorTipoModelList.add(ColaboradorTipoModel.fromJson(colaboradorTipoModel));
					}
					return colaboradorTipoModelList;
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

	Future<ColaboradorTipoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/colaborador-tipo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorTipoModelJson = json.decode(response.body);
					return ColaboradorTipoModel.fromJson(colaboradorTipoModelJson);		 
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

	Future<ColaboradorTipoModel?>? insert(ColaboradorTipoModel colaboradorTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/colaborador-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: colaboradorTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorTipoModelJson = json.decode(response.body);
					return ColaboradorTipoModel.fromJson(colaboradorTipoModelJson);
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

	Future<ColaboradorTipoModel?>? update(ColaboradorTipoModel colaboradorTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/colaborador-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: colaboradorTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var colaboradorTipoModelJson = json.decode(response.body);
					return ColaboradorTipoModel.fromJson(colaboradorTipoModelJson);
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
				Uri.tryParse('$endpoint/colaborador-tipo/$pk')!,
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
