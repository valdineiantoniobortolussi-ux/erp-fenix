class PontoParametroDomain {
	PontoParametroDomain._();

	static getTratamentoHoraMais(String? tratamentoHoraMais) { 
		switch (tratamentoHoraMais) { 
			case '': 
			case 'E': 
				return 'Extra'; 
			case 'B': 
				return 'Banco Horas'; 
			default: 
				return null; 
		} 
	} 

	static setTratamentoHoraMais(String? tratamentoHoraMais) { 
		switch (tratamentoHoraMais) { 
			case 'Extra': 
				return 'E'; 
			case 'Banco Horas': 
				return 'B'; 
			default: 
				return null; 
		} 
	}

	static getTratamentoHoraMenos(String? tratamentoHoraMenos) { 
		switch (tratamentoHoraMenos) { 
			case '': 
			case 'F': 
				return 'Falta'; 
			case 'B': 
				return 'Banco Horas'; 
			default: 
				return null; 
		} 
	} 

	static setTratamentoHoraMenos(String? tratamentoHoraMenos) { 
		switch (tratamentoHoraMenos) { 
			case 'Falta': 
				return 'F'; 
			case 'Banco Horas': 
				return 'B'; 
			default: 
				return null; 
		} 
	}

}