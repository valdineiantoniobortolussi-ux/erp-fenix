import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaDeducoesSafraApiProvider extends ApiProviderBase {

	Future<List<NfeCanaDeducoesSafraModel>?> getList({Filter? filter}) async {
		List<NfeCanaDeducoesSafraModel> nfeCanaDeducoesSafraModelList = [];

		try {
			handleFilter(filter, '/nfe-cana-deducoes-safra/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaDeducoesSafraModelJson = json.decode(response.body) as List<dynamic>;
					for (var nfeCanaDeducoesSafraModel in nfeCanaDeducoesSafraModelJson) {
						nfeCanaDeducoesSafraModelList.add(NfeCanaDeducoesSafraModel.fromJson(nfeCanaDeducoesSafraModel));
					}
					return nfeCanaDeducoesSafraModelList;
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

	Future<NfeCanaDeducoesSafraModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/nfe-cana-deducoes-safra/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaDeducoesSafraModelJson = json.decode(response.body);
					return NfeCanaDeducoesSafraModel.fromJson(nfeCanaDeducoesSafraModelJson);		 
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

	Future<NfeCanaDeducoesSafraModel?>? insert(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/nfe-cana-deducoes-safra')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCanaDeducoesSafraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaDeducoesSafraModelJson = json.decode(response.body);
					return NfeCanaDeducoesSafraModel.fromJson(nfeCanaDeducoesSafraModelJson);
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

	Future<NfeCanaDeducoesSafraModel?>? update(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/nfe-cana-deducoes-safra')!,
				headers: ApiProviderBase.headerRequisition(),
				body: nfeCanaDeducoesSafraModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var nfeCanaDeducoesSafraModelJson = json.decode(response.body);
					return NfeCanaDeducoesSafraModel.fromJson(nfeCanaDeducoesSafraModelJson);
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
				Uri.tryParse('$endpoint/nfe-cana-deducoes-safra/$pk')!,
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
