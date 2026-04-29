import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoNfeApiProvider extends ApiProviderBase {

	Future<List<MdfeInformacaoNfeModel>?> getList({Filter? filter}) async {
		List<MdfeInformacaoNfeModel> mdfeInformacaoNfeModelList = [];

		try {
			handleFilter(filter, '/mdfe-informacao-nfe/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoNfeModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeInformacaoNfeModel in mdfeInformacaoNfeModelJson) {
						mdfeInformacaoNfeModelList.add(MdfeInformacaoNfeModel.fromJson(mdfeInformacaoNfeModel));
					}
					return mdfeInformacaoNfeModelList;
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

	Future<MdfeInformacaoNfeModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-informacao-nfe/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoNfeModelJson = json.decode(response.body);
					return MdfeInformacaoNfeModel.fromJson(mdfeInformacaoNfeModelJson);		 
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

	Future<MdfeInformacaoNfeModel?>? insert(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-informacao-nfe')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeInformacaoNfeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoNfeModelJson = json.decode(response.body);
					return MdfeInformacaoNfeModel.fromJson(mdfeInformacaoNfeModelJson);
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

	Future<MdfeInformacaoNfeModel?>? update(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-informacao-nfe')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeInformacaoNfeModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoNfeModelJson = json.decode(response.body);
					return MdfeInformacaoNfeModel.fromJson(mdfeInformacaoNfeModelJson);
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
				Uri.tryParse('$endpoint/mdfe-informacao-nfe/$pk')!,
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
