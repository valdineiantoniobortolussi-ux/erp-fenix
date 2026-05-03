import 'dart:convert';
import 'package:frotas/app/data/provider/api/api_provider_base.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaCombustivelTipoApiProvider extends ApiProviderBase {

	Future<List<FrotaCombustivelTipoModel>?> getList({Filter? filter}) async {
		List<FrotaCombustivelTipoModel> frotaCombustivelTipoModelList = [];

		try {
			handleFilter(filter, '/frota-combustivel-tipo/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaCombustivelTipoModelJson = json.decode(response.body) as List<dynamic>;
					for (var frotaCombustivelTipoModel in frotaCombustivelTipoModelJson) {
						frotaCombustivelTipoModelList.add(FrotaCombustivelTipoModel.fromJson(frotaCombustivelTipoModel));
					}
					return frotaCombustivelTipoModelList;
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

	Future<FrotaCombustivelTipoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/frota-combustivel-tipo/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaCombustivelTipoModelJson = json.decode(response.body);
					return FrotaCombustivelTipoModel.fromJson(frotaCombustivelTipoModelJson);		 
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

	Future<FrotaCombustivelTipoModel?>? insert(FrotaCombustivelTipoModel frotaCombustivelTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/frota-combustivel-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaCombustivelTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaCombustivelTipoModelJson = json.decode(response.body);
					return FrotaCombustivelTipoModel.fromJson(frotaCombustivelTipoModelJson);
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

	Future<FrotaCombustivelTipoModel?>? update(FrotaCombustivelTipoModel frotaCombustivelTipoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/frota-combustivel-tipo')!,
				headers: ApiProviderBase.headerRequisition(),
				body: frotaCombustivelTipoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var frotaCombustivelTipoModelJson = json.decode(response.body);
					return FrotaCombustivelTipoModel.fromJson(frotaCombustivelTipoModelJson);
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
				Uri.tryParse('$endpoint/frota-combustivel-tipo/$pk')!,
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
