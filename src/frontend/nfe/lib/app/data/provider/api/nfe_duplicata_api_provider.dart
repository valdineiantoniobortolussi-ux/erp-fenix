import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeDuplicataApiProvider extends ApiProviderBase {

	Future<List<NfeDuplicataModel>?> getList({Filter? filter}) async {
		List<NfeDuplicataModel> nfeDuplicataModelList = [];

		try {
			handleFilter(filter, '/nfe-duplicata/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeDuplicataModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeDuplicataModel in nfeDuplicataModelJson) {
						nfeDuplicataModelList.add(NfeDuplicataModel.fromJson(nfeDuplicataModel));
					}
					return nfeDuplicataModelList;
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

	Future<NfeDuplicataModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-duplicata/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeDuplicataModelJson = json.decode(response.body);
					return NfeDuplicataModel.fromJson(nfeDuplicataModelJson);		 
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

	Future<NfeDuplicataModel?>? insert(NfeDuplicataModel nfeDuplicataModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-duplicata')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeDuplicataModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeDuplicataModelJson = json.decode(response.body);
					return NfeDuplicataModel.fromJson(nfeDuplicataModelJson);
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

	Future<NfeDuplicataModel?>? update(NfeDuplicataModel nfeDuplicataModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-duplicata')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeDuplicataModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeDuplicataModelJson = json.decode(response.body);
					return NfeDuplicataModel.fromJson(nfeDuplicataModelJson);
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
				Uri.tryParse('$endpoint/nfe-duplicata/$pk')!,
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
