class PatrimTipoMovimentacaoDomain {
	PatrimTipoMovimentacaoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '1': 
				return '1=Distribuição'; 
			case '2': 
				return '2=Remanejamento'; 
			case '3': 
				return '3=Saída Provisória'; 
			case '4': 
				return '4=Empréstimo'; 
			case '5': 
				return '5=Arrendamento'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case '1=Distribuição': 
				return '1'; 
			case '2=Remanejamento': 
				return '2'; 
			case '3=Saída Provisória': 
				return '3'; 
			case '4=Empréstimo': 
				return '4'; 
			case '5=Arrendamento': 
				return '5'; 
			default: 
				return null; 
		} 
	}

}