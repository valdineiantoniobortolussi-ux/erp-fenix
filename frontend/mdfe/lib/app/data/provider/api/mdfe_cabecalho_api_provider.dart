import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeCabecalhoApiProvider extends ApiProviderBase {

	Future<List<MdfeCabecalhoModel>?> getList({Filter? filter}) async {
		List<MdfeCabecalhoModel> mdfeCabecalhoModelList = [];

		try {
			handleFilter(filter, '/mdfe-cabecalho/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeCabecalhoModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeCabecalhoModel in mdfeCabecalhoModelJson) {
						mdfeCabecalhoModelList.add(MdfeCabecalhoModel.fromJson(mdfeCabecalhoModel));
					}
					return mdfeCabecalhoModelList;
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

	Future<MdfeCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-cabecalho/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeCabecalhoModelJson = json.decode(response.body);
					return MdfeCabecalhoModel.fromJson(mdfeCabecalhoModelJson);		 
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

	Future<MdfeCabecalhoModel?>? insert(MdfeCabecalhoModel mdfeCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeCabecalhoModelJson = json.decode(response.body);
					return MdfeCabecalhoModel.fromJson(mdfeCabecalhoModelJson);
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

	Future<MdfeCabecalhoModel?>? update(MdfeCabecalhoModel mdfeCabecalhoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-cabecalho')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeCabecalhoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeCabecalhoModelJson = json.decode(response.body);
					return MdfeCabecalhoModel.fromJson(mdfeCabecalhoModelJson);
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
				Uri.tryParse('$endpoint/mdfe-cabecalho/$pk')!,
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
