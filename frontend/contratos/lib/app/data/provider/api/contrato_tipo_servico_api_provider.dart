import 'dart:convert';
import 'package:contratos/app/data/provider/api/api_provider_base.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTipoServicoApiProvider extends ApiProviderBase {

	Future<List<ContratoTipoServicoModel>?> getList({Filter? filter}) async {
		List<ContratoTipoServicoModel> contratoTipoServicoModelList = [];

		try {
			handleFilter(filter, '/contrato-tipo-servico/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTipoServicoModelJson = json.decode(response.body) as List<dynamic>;
					for (var contratoTipoServicoModel in contratoTipoServicoModelJson) {
						contratoTipoServicoModelList.add(ContratoTipoServicoModel.fromJson(contratoTipoServicoModel));
					}
					return contratoTipoServicoModelList;
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

	Future<ContratoTipoServicoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/contrato-tipo-servico/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTipoServicoModelJson = json.decode(response.body);
					return ContratoTipoServicoModel.fromJson(contratoTipoServicoModelJson);		 
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

	Future<ContratoTipoServicoModel?>? insert(ContratoTipoServicoModel contratoTipoServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/contrato-tipo-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoTipoServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTipoServicoModelJson = json.decode(response.body);
					return ContratoTipoServicoModel.fromJson(contratoTipoServicoModelJson);
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

	Future<ContratoTipoServicoModel?>? update(ContratoTipoServicoModel contratoTipoServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/contrato-tipo-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: contratoTipoServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var contratoTipoServicoModelJson = json.decode(response.body);
					return ContratoTipoServicoModel.fromJson(contratoTipoServicoModelJson);
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
				Uri.tryParse('$endpoint/contrato-tipo-servico/$pk')!,
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
