import 'dart:convert';
import 'package:mdfe/app/data/provider/api/api_provider_base.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoCteApiProvider extends ApiProviderBase {

	Future<List<MdfeInformacaoCteModel>?> getList({Filter? filter}) async {
		List<MdfeInformacaoCteModel> mdfeInformacaoCteModelList = [];

		try {
			handleFilter(filter, '/mdfe-informacao-cte/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoCteModelJson = json.decode(response.body) as List<dynamic>;
					for (var mdfeInformacaoCteModel in mdfeInformacaoCteModelJson) {
						mdfeInformacaoCteModelList.add(MdfeInformacaoCteModel.fromJson(mdfeInformacaoCteModel));
					}
					return mdfeInformacaoCteModelList;
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

	Future<MdfeInformacaoCteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/mdfe-informacao-cte/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoCteModelJson = json.decode(response.body);
					return MdfeInformacaoCteModel.fromJson(mdfeInformacaoCteModelJson);		 
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

	Future<MdfeInformacaoCteModel?>? insert(MdfeInformacaoCteModel mdfeInformacaoCteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/mdfe-informacao-cte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeInformacaoCteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoCteModelJson = json.decode(response.body);
					return MdfeInformacaoCteModel.fromJson(mdfeInformacaoCteModelJson);
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

	Future<MdfeInformacaoCteModel?>? update(MdfeInformacaoCteModel mdfeInformacaoCteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/mdfe-informacao-cte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: mdfeInformacaoCteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var mdfeInformacaoCteModelJson = json.decode(response.body);
					return MdfeInformacaoCteModel.fromJson(mdfeInformacaoCteModelJson);
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
				Uri.tryParse('$endpoint/mdfe-informacao-cte/$pk')!,
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
