import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfCargaLacreApiProvider extends ApiProviderBase {

	Future<List<CteInfNfCargaLacreModel>?> getList({Filter? filter}) async {
		List<CteInfNfCargaLacreModel> cteInfNfCargaLacreModelList = [];

		try {
			handleFilter(filter, '/cte-inf-nf-carga-lacre/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfCargaLacreModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteInfNfCargaLacreModel in cteInfNfCargaLacreModelJson) {
						cteInfNfCargaLacreModelList.add(CteInfNfCargaLacreModel.fromJson(cteInfNfCargaLacreModel));
					}
					return cteInfNfCargaLacreModelList;
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

	Future<CteInfNfCargaLacreModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-inf-nf-carga-lacre/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfCargaLacreModelJson = json.decode(response.body);
					return CteInfNfCargaLacreModel.fromJson(cteInfNfCargaLacreModelJson);		 
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

	Future<CteInfNfCargaLacreModel?>? insert(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-inf-nf-carga-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInfNfCargaLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfCargaLacreModelJson = json.decode(response.body);
					return CteInfNfCargaLacreModel.fromJson(cteInfNfCargaLacreModelJson);
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

	Future<CteInfNfCargaLacreModel?>? update(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-inf-nf-carga-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInfNfCargaLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfCargaLacreModelJson = json.decode(response.body);
					return CteInfNfCargaLacreModel.fromJson(cteInfNfCargaLacreModelJson);
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
				Uri.tryParse('$endpoint/cte-inf-nf-carga-lacre/$pk')!,
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
