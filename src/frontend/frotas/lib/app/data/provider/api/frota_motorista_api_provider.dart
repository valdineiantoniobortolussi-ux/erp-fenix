import 'dart:convert';
import 'package:frotas/app/data/provider/api/api_provider_base.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaMotoristaApiProvider extends ApiProviderBase {

	Future<List<FrotaMotoristaModel>?> getList({Filter? filter}) async {
		List<FrotaMotoristaModel> frotaMotoristaModelList = [];

		try {
			handleFilter(filter, '/frota-motorista/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaMotoristaModelJson = json.decode(response.body) as List<dynamic>;
					for (var frotaMotoristaModel in frotaMotoristaModelJson) {
						frotaMotoristaModelList.add(FrotaMotoristaModel.fromJson(frotaMotoristaModel));
					}
					return frotaMotoristaModelList;
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

	Future<FrotaMotoristaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/frota-motorista/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaMotoristaModelJson = json.decode(response.body);
					return FrotaMotoristaModel.fromJson(frotaMotoristaModelJson);		 
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

	Future<FrotaMotoristaModel?>? insert(FrotaMotoristaModel frotaMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/frota-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaMotoristaModelJson = json.decode(response.body);
					return FrotaMotoristaModel.fromJson(frotaMotoristaModelJson);
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

	Future<FrotaMotoristaModel?>? update(FrotaMotoristaModel frotaMotoristaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/frota-motorista')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaMotoristaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaMotoristaModelJson = json.decode(response.body);
					return FrotaMotoristaModel.fromJson(frotaMotoristaModelJson);
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
				Uri.tryParse('$endpoint/frota-motorista/$pk')!,
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
