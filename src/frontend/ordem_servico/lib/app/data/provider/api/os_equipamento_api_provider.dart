import 'dart:convert';
import 'package:ordem_servico/app/data/provider/api/api_provider_base.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsEquipamentoApiProvider extends ApiProviderBase {

	Future<List<OsEquipamentoModel>?> getList({Filter? filter}) async {
		List<OsEquipamentoModel> osEquipamentoModelList = [];

		try {
			handleFilter(filter, '/os-equipamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osEquipamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var osEquipamentoModel in osEquipamentoModelJson) {
						osEquipamentoModelList.add(OsEquipamentoModel.fromJson(osEquipamentoModel));
					}
					return osEquipamentoModelList;
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

	Future<OsEquipamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/os-equipamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osEquipamentoModelJson = json.decode(response.body);
					return OsEquipamentoModel.fromJson(osEquipamentoModelJson);		 
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

	Future<OsEquipamentoModel?>? insert(OsEquipamentoModel osEquipamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/os-equipamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osEquipamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osEquipamentoModelJson = json.decode(response.body);
					return OsEquipamentoModel.fromJson(osEquipamentoModelJson);
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

	Future<OsEquipamentoModel?>? update(OsEquipamentoModel osEquipamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/os-equipamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: osEquipamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var osEquipamentoModelJson = json.decode(response.body);
					return OsEquipamentoModel.fromJson(osEquipamentoModelJson);
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
				Uri.tryParse('$endpoint/os-equipamento/$pk')!,
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
