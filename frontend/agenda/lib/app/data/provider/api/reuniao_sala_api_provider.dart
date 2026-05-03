import 'dart:convert';
import 'package:agenda/app/data/provider/api/api_provider_base.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class ReuniaoSalaApiProvider extends ApiProviderBase {

	Future<List<ReuniaoSalaModel>?> getList({Filter? filter}) async {
		List<ReuniaoSalaModel> reuniaoSalaModelList = [];

		try {
			handleFilter(filter, '/reuniao-sala/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var reuniaoSalaModelJson = json.decode(response.body) as List<dynamic>;
					for (var reuniaoSalaModel in reuniaoSalaModelJson) {
						reuniaoSalaModelList.add(ReuniaoSalaModel.fromJson(reuniaoSalaModel));
					}
					return reuniaoSalaModelList;
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

	Future<ReuniaoSalaModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/reuniao-sala/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var reuniaoSalaModelJson = json.decode(response.body);
					return ReuniaoSalaModel.fromJson(reuniaoSalaModelJson);		 
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

	Future<ReuniaoSalaModel?>? insert(ReuniaoSalaModel reuniaoSalaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/reuniao-sala')!,
				headers: ApiProviderBase.headerRequisition(),
				body: reuniaoSalaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var reuniaoSalaModelJson = json.decode(response.body);
					return ReuniaoSalaModel.fromJson(reuniaoSalaModelJson);
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

	Future<ReuniaoSalaModel?>? update(ReuniaoSalaModel reuniaoSalaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/reuniao-sala')!,
				headers: ApiProviderBase.headerRequisition(),
				body: reuniaoSalaModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var reuniaoSalaModelJson = json.decode(response.body);
					return ReuniaoSalaModel.fromJson(reuniaoSalaModelJson);
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
				Uri.tryParse('$endpoint/reuniao-sala/$pk')!,
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
