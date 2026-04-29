import 'dart:convert';
import 'package:wms/app/data/provider/api/api_provider_base.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsAgendamentoApiProvider extends ApiProviderBase {

	Future<List<WmsAgendamentoModel>?> getList({Filter? filter}) async {
		List<WmsAgendamentoModel> wmsAgendamentoModelList = [];

		try {
			handleFilter(filter, '/wms-agendamento/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsAgendamentoModelJson = json.decode(response.body) as List<dynamic>;
					for (var wmsAgendamentoModel in wmsAgendamentoModelJson) {
						wmsAgendamentoModelList.add(WmsAgendamentoModel.fromJson(wmsAgendamentoModel));
					}
					return wmsAgendamentoModelList;
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

	Future<WmsAgendamentoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/wms-agendamento/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsAgendamentoModelJson = json.decode(response.body);
					return WmsAgendamentoModel.fromJson(wmsAgendamentoModelJson);		 
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

	Future<WmsAgendamentoModel?>? insert(WmsAgendamentoModel wmsAgendamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/wms-agendamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsAgendamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsAgendamentoModelJson = json.decode(response.body);
					return WmsAgendamentoModel.fromJson(wmsAgendamentoModelJson);
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

	Future<WmsAgendamentoModel?>? update(WmsAgendamentoModel wmsAgendamentoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/wms-agendamento')!,
				headers: ApiProviderBase.headerRequisition(),
				body: wmsAgendamentoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var wmsAgendamentoModelJson = json.decode(response.body);
					return WmsAgendamentoModel.fromJson(wmsAgendamentoModelJson);
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
				Uri.tryParse('$endpoint/wms-agendamento/$pk')!,
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
