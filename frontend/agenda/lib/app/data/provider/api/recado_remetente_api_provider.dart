import 'dart:convert';
import 'package:agenda/app/data/provider/api/api_provider_base.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class RecadoRemetenteApiProvider extends ApiProviderBase {

	Future<List<RecadoRemetenteModel>?> getList({Filter? filter}) async {
		List<RecadoRemetenteModel> recadoRemetenteModelList = [];

		try {
			handleFilter(filter, '/recado-remetente/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var recadoRemetenteModelJson = json.decode(response.body) as List<dynamic>;
					for (var recadoRemetenteModel in recadoRemetenteModelJson) {
						recadoRemetenteModelList.add(RecadoRemetenteModel.fromJson(recadoRemetenteModel));
					}
					return recadoRemetenteModelList;
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

	Future<RecadoRemetenteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/recado-remetente/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var recadoRemetenteModelJson = json.decode(response.body);
					return RecadoRemetenteModel.fromJson(recadoRemetenteModelJson);		 
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

	Future<RecadoRemetenteModel?>? insert(RecadoRemetenteModel recadoRemetenteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/recado-remetente')!,
				headers: ApiProviderBase.headerRequisition(),
				body: recadoRemetenteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var recadoRemetenteModelJson = json.decode(response.body);
					return RecadoRemetenteModel.fromJson(recadoRemetenteModelJson);
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

	Future<RecadoRemetenteModel?>? update(RecadoRemetenteModel recadoRemetenteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/recado-remetente')!,
				headers: ApiProviderBase.headerRequisition(),
				body: recadoRemetenteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var recadoRemetenteModelJson = json.decode(response.body);
					return RecadoRemetenteModel.fromJson(recadoRemetenteModelJson);
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
				Uri.tryParse('$endpoint/recado-remetente/$pk')!,
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
