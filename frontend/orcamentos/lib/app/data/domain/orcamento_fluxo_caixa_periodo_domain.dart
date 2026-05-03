class OrcamentoFluxoCaixaPeriodoDomain {
	OrcamentoFluxoCaixaPeriodoDomain._();

	static getPeriodo(String? periodo) { 
		switch (periodo) { 
			case '': 
			case '0': 
				return '01=Diário'; 
			case '1': 
				return '02=Semanal'; 
			case '2': 
				return '03=Mensal'; 
			case '3': 
				return '04=Bimestral'; 
			case '4': 
				return '05=Trimestral'; 
			case '5': 
				return '06=Semestral'; 
			case '6': 
				return '07=Anual'; 
			default: 
				return null; 
		} 
	} 

	static setPeriodo(String? periodo) { 
		switch (periodo) { 
			case '01=Diário': 
				return '0'; 
			case '02=Semanal': 
				return '1'; 
			case '03=Mensal': 
				return '2'; 
			case '04=Bimestral': 
				return '3'; 
			case '05=Trimestral': 
				return '4'; 
			case '06=Semestral': 
				return '5'; 
			case '07=Anual': 
				return '6'; 
			default: 
				return null; 
		} 
	}

}