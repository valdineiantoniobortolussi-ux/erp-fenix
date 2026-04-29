import 'dart:convert';
import 'package:financeiro/app/data/provider/api/api_provider_base.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoAgenciaApiProvider extends ApiProviderBase {

	Future<List<BancoAgenciaModel>?> getList({Filter? filter}) async {
		List<BancoAgenciaModel> bancoAgenciaModelList = [];

		try {
			handleFilter(filter, '/banco-agencia/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoAgenciaModelJson = json.decode(response.body) as List<dynamic>;
					for (var bancoAgenciaModel in bancoAgenciaModelJson) {
						bancoAgenciaModelList.add(BancoAgenciaModel.fromJson(bancoAgenciaModel));
					}
					return bancoAgenciaModelList;
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

	Future<BancoAgenciaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/banco-agencia/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoAgenciaModelJson = json.decode(response.body);
					return BancoAgenciaModel.fromJson(bancoAgenciaModelJson);		 
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

	Future<BancoAgenciaModel?>? insert(BancoAgenciaModel bancoAgenciaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/banco-agencia')!,
				headers: ApiProviderBase.headerRequisition(),
				body: bancoAgenciaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoAgenciaModelJson = json.decode(response.body);
					return BancoAgenciaModel.fromJson(bancoAgenciaModelJson);
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

	Future<BancoAgenciaModel?>? update(BancoAgenciaModel bancoAgenciaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/banco-agencia')!,
				headers: ApiProviderBase.headerRequisition(),
				body: bancoAgenciaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var bancoAgenciaModelJson = json.decode(response.body);
					return BancoAgenciaModel.fromJson(bancoAgenciaModelJson);
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
				Uri.tryParse('$endpoint/banco-agencia/$pk')!,
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
