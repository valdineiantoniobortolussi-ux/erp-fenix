import 'dart:convert';
import 'package:pcp/app/data/provider/api/api_provider_base.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpInstrucaoApiProvider extends ApiProviderBase {

	Future<List<PcpInstrucaoModel>?> getList({Filter? filter}) async {
		List<PcpInstrucaoModel> pcpInstrucaoModelList = [];

		try {
			handleFilter(filter, '/pcp-instrucao/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpInstrucaoModelJson = json.decode(response.body) as List<dynamic>;
					for (var pcpInstrucaoModel in pcpInstrucaoModelJson) {
						pcpInstrucaoModelList.add(PcpInstrucaoModel.fromJson(pcpInstrucaoModel));
					}
					return pcpInstrucaoModelList;
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

	Future<PcpInstrucaoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/pcp-instrucao/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpInstrucaoModelJson = json.decode(response.body);
					return PcpInstrucaoModel.fromJson(pcpInstrucaoModelJson);		 
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

	Future<PcpInstrucaoModel?>? insert(PcpInstrucaoModel pcpInstrucaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/pcp-instrucao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpInstrucaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpInstrucaoModelJson = json.decode(response.body);
					return PcpInstrucaoModel.fromJson(pcpInstrucaoModelJson);
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

	Future<PcpInstrucaoModel?>? update(PcpInstrucaoModel pcpInstrucaoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/pcp-instrucao')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpInstrucaoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpInstrucaoModelJson = json.decode(response.body);
					return PcpInstrucaoModel.fromJson(pcpInstrucaoModelJson);
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
				Uri.tryParse('$endpoint/pcp-instrucao/$pk')!,
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
