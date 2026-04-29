import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

part 'pcp_instrucao_dao.g.dart';

@DriftAccessor(tables: [
	PcpInstrucaos,
])
class PcpInstrucaoDao extends DatabaseAccessor<AppDatabase> with _$PcpInstrucaoDaoMixin {
	final AppDatabase db;

	List<PcpInstrucao> pcpInstrucaoList = []; 
	List<PcpInstrucaoGrouped> pcpInstrucaoGroupedList = []; 

	PcpInstrucaoDao(this.db) : super(db);

	Future<List<PcpInstrucao>> getList() async {
		pcpInstrucaoList = await select(pcpInstrucaos).get();
		return pcpInstrucaoList;
	}

	Future<List<PcpInstrucao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pcpInstrucaoList = await (select(pcpInstrucaos)..where((t) => expression)).get();
		return pcpInstrucaoList;	 
	}

	Future<List<PcpInstrucaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pcpInstrucaos)
			.join([]);

		if (field != null && field != '') { 
			final column = pcpInstrucaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pcpInstrucaoGroupedList = await query.map((row) {
			final pcpInstrucao = row.readTableOrNull(pcpInstrucaos); 

			return PcpInstrucaoGrouped(
				pcpInstrucao: pcpInstrucao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pcpInstrucaoGrouped in pcpInstrucaoGroupedList) {
		//}		

		return pcpInstrucaoGroupedList;	
	}

	Future<PcpInstrucao?> getObject(dynamic pk) async {
		return await (select(pcpInstrucaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PcpInstrucao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM pcp_instrucao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PcpInstrucao;		 
	} 

	Future<PcpInstrucaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PcpInstrucaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pcpInstrucao = object.pcpInstrucao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pcpInstrucaos).insert(object.pcpInstrucao!);
			object.pcpInstrucao = object.pcpInstrucao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PcpInstrucaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pcpInstrucaos).replace(object.pcpInstrucao!);
		});	 
	} 

	Future<int> deleteObject(PcpInstrucaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pcpInstrucaos).delete(object.pcpInstrucao!);
		});		
	}

	Future<void> insertChildren(PcpInstrucaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PcpInstrucaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from pcp_instrucao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}