import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfTransporteLacreApiProvider extends ApiProviderBase {

	Future<List<CteInfNfTransporteLacreModel>?> getList({Filter? filter}) async {
		List<CteInfNfTransporteLacreModel> cteInfNfTransporteLacreModelList = [];

		try {
			handleFilter(filter, '/cte-inf-nf-transporte-lacre/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfTransporteLacreModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteInfNfTransporteLacreModel in cteInfNfTransporteLacreModelJson) {
						cteInfNfTransporteLacreModelList.add(CteInfNfTransporteLacreModel.fromJson(cteInfNfTransporteLacreModel));
					}
					return cteInfNfTransporteLacreModelList;
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

	Future<CteInfNfTransporteLacreModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-inf-nf-transporte-lacre/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfTransporteLacreModelJson = json.decode(response.body);
					return CteInfNfTransporteLacreModel.fromJson(cteInfNfTransporteLacreModelJson);		 
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

	Future<CteInfNfTransporteLacreModel?>? insert(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-inf-nf-transporte-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInfNfTransporteLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfTransporteLacreModelJson = json.decode(response.body);
					return CteInfNfTransporteLacreModel.fromJson(cteInfNfTransporteLacreModelJson);
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

	Future<CteInfNfTransporteLacreModel?>? update(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-inf-nf-transporte-lacre')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInfNfTransporteLacreModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInfNfTransporteLacreModelJson = json.decode(response.body);
					return CteInfNfTransporteLacreModel.fromJson(cteInfNfTransporteLacreModelJson);
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
				Uri.tryParse('$endpoint/cte-inf-nf-transporte-lacre/$pk')!,
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
