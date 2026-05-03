import 'dart:convert';
import 'package:sped/app/data/provider/api/api_provider_base.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SpedFiscalApiProvider extends ApiProviderBase {

	Future<List<SpedFiscalModel>?> getList({Filter? filter}) async {
		List<SpedFiscalModel> spedFiscalModelList = [];

		try {
			handleFilter(filter, '/sped-fiscal/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedFiscalModelJson = json.decode(response.body) as List<dynamic>;
					for (var spedFiscalModel in spedFiscalModelJson) {
						spedFiscalModelList.add(SpedFiscalModel.fromJson(spedFiscalModel));
					}
					return spedFiscalModelList;
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

	Future<SpedFiscalModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/sped-fiscal/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedFiscalModelJson = json.decode(response.body);
					return SpedFiscalModel.fromJson(spedFiscalModelJson);		 
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

	Future<SpedFiscalModel?>? insert(SpedFiscalModel spedFiscalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/sped-fiscal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: spedFiscalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedFiscalModelJson = json.decode(response.body);
					return SpedFiscalModel.fromJson(spedFiscalModelJson);
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

	Future<SpedFiscalModel?>? update(SpedFiscalModel spedFiscalModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/sped-fiscal')!,
				headers: ApiProviderBase.headerRequisition(),
				body: spedFiscalModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var spedFiscalModelJson = json.decode(response.body);
					return SpedFiscalModel.fromJson(spedFiscalModelJson);
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
				Uri.tryParse('$endpoint/sped-fiscal/$pk')!,
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
