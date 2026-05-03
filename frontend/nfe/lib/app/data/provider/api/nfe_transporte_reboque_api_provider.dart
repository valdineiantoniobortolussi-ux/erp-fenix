import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteReboqueApiProvider extends ApiProviderBase {

	Future<List<NfeTransporteReboqueModel>?> getList({Filter? filter}) async {
		List<NfeTransporteReboqueModel> nfeTransporteReboqueModelList = [];

		try {
			handleFilter(filter, '/nfe-transporte-reboque/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteReboqueModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeTransporteReboqueModel in nfeTransporteReboqueModelJson) {
						nfeTransporteReboqueModelList.add(NfeTransporteReboqueModel.fromJson(nfeTransporteReboqueModel));
					}
					return nfeTransporteReboqueModelList;
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

	Future<NfeTransporteReboqueModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-transporte-reboque/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteReboqueModelJson = json.decode(response.body);
					return NfeTransporteReboqueModel.fromJson(nfeTransporteReboqueModelJson);		 
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

	Future<NfeTransporteReboqueModel?>? insert(NfeTransporteReboqueModel nfeTransporteReboqueModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-transporte-reboque')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteReboqueModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteReboqueModelJson = json.decode(response.body);
					return NfeTransporteReboqueModel.fromJson(nfeTransporteReboqueModelJson);
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

	Future<NfeTransporteReboqueModel?>? update(NfeTransporteReboqueModel nfeTransporteReboqueModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-transporte-reboque')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeTransporteReboqueModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeTransporteReboqueModelJson = json.decode(response.body);
					return NfeTransporteReboqueModel.fromJson(nfeTransporteReboqueModelJson);
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
				Uri.tryParse('$endpoint/nfe-transporte-reboque/$pk')!,
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
