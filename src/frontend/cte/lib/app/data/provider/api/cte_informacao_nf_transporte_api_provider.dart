import 'dart:convert';
import 'package:cte/app/data/provider/api/api_provider_base.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInformacaoNfTransporteApiProvider extends ApiProviderBase {

	Future<List<CteInformacaoNfTransporteModel>?> getList({Filter? filter}) async {
		List<CteInformacaoNfTransporteModel> cteInformacaoNfTransporteModelList = [];

		try {
			handleFilter(filter, '/cte-informacao-nf-transporte/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfTransporteModelJson = json.decode(response.body) as List<dynamic>;
					for (var cteInformacaoNfTransporteModel in cteInformacaoNfTransporteModelJson) {
						cteInformacaoNfTransporteModelList.add(CteInformacaoNfTransporteModel.fromJson(cteInformacaoNfTransporteModel));
					}
					return cteInformacaoNfTransporteModelList;
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

	Future<CteInformacaoNfTransporteModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/cte-informacao-nf-transporte/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfTransporteModelJson = json.decode(response.body);
					return CteInformacaoNfTransporteModel.fromJson(cteInformacaoNfTransporteModelJson);		 
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

	Future<CteInformacaoNfTransporteModel?>? insert(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/cte-informacao-nf-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInformacaoNfTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfTransporteModelJson = json.decode(response.body);
					return CteInformacaoNfTransporteModel.fromJson(cteInformacaoNfTransporteModelJson);
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

	Future<CteInformacaoNfTransporteModel?>? update(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/cte-informacao-nf-transporte')!,
				headers: ApiProviderBase.headerRequisition(),
				body: cteInformacaoNfTransporteModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var cteInformacaoNfTransporteModelJson = json.decode(response.body);
					return CteInformacaoNfTransporteModel.fromJson(cteInformacaoNfTransporteModelJson);
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
				Uri.tryParse('$endpoint/cte-informacao-nf-transporte/$pk')!,
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
