class ContabilFechamentoDomain {
	ContabilFechamentoDomain._();

	static getCriterioLancamento(String? criterioLancamento) { 
		switch (criterioLancamento) { 
			case '': 
			case '0': 
				return 'Livre'; 
			case '1': 
				return 'Avisar'; 
			case '2': 
				return 'Não Permitir'; 
			default: 
				return null; 
		} 
	} 

	static setCriterioLancamento(String? criterioLancamento) { 
		switch (criterioLancamento) { 
			case 'Livre': 
				return '0'; 
			case 'Avisar': 
				return '1'; 
			case 'Não Permitir': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}