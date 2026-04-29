import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioCiotApiProvider extends ApiProviderBase {

	Future<List<MdfeRodoviarioCiotModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioCiotModel> mdfeRodoviarioCiotModelList = [];

		try {
			handleFilter(filter, '/mdfe-rodoviario-ciot/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioCiotModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeRodoviarioCiotModel in mdfeRodoviarioCiotModelJson) {
						mdfeRodoviarioCiotModelList.add(MdfeRodoviarioCiotModel.fromJson(mdfeRodoviarioCiotModel));
					}
					return mdfeRodoviarioCiotModelList;
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

	Future<MdfeRodoviarioCiotModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-rodoviario-ciot/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioCiotModelJson = json.decode(response.body);
					return MdfeRodoviarioCiotModel.fromJson(mdfeRodoviarioCiotModelJson);		 
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

	Future<MdfeRodoviarioCiotModel?>? insert(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-rodoviario-ciot')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioCiotModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioCiotModelJson = json.decode(response.body);
					return MdfeRodoviarioCiotModel.fromJson(mdfeRodoviarioCiotModelJson);
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

	Future<MdfeRodoviarioCiotModel?>? update(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-rodoviario-ciot')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeRodoviarioCiotModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeRodoviarioCiotModelJson = json.decode(response.body);
					return MdfeRodoviarioCiotModel.fromJson(mdfeRodoviarioCiotModelJson);
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
				Uri.tryParse('$endpoint/mdfe-rodoviario-ciot/$pk')!,
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
