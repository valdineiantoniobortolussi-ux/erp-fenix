import 'dart:convert';
import 'package:ponto/app/data/provider/api/api_provider_base.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoBancoHorasApiProvider extends ApiProviderBase {

	Future<List<PontoBancoHorasModel>?> getList({Filter? filter}) async {
		List<PontoBancoHorasModel> pontoBancoHorasModelList = [];

		try {
			handleFilter(filter, '/ponto-banco-horas/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoBancoHorasModelJson = json.decode(response.body) as List<dynamic>;
					for (var pontoBancoHorasModel in pontoBancoHorasModelJson) {
						pontoBancoHorasModelList.add(PontoBancoHorasModel.fromJson(pontoBancoHorasModel));
					}
					return pontoBancoHorasModelList;
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

	Future<PontoBancoHorasModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/ponto-banco-horas/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoBancoHorasModelJson = json.decode(response.body);
					return PontoBancoHorasModel.fromJson(pontoBancoHorasModelJson);		 
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

	Future<PontoBancoHorasModel?>? insert(PontoBancoHorasModel pontoBancoHorasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/ponto-banco-horas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoBancoHorasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoBancoHorasModelJson = json.decode(response.body);
					return PontoBancoHorasModel.fromJson(pontoBancoHorasModelJson);
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

	Future<PontoBancoHorasModel?>? update(PontoBancoHorasModel pontoBancoHorasModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/ponto-banco-horas')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pontoBancoHorasModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pontoBancoHorasModelJson = json.decode(response.body);
					return PontoBancoHorasModel.fromJson(pontoBancoHorasModelJson);
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
				Uri.tryParse('$endpoint/ponto-banco-horas/$pk')!,
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
