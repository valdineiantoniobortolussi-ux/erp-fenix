class ContabilLancamentoDetalheDomain {
	ContabilLancamentoDetalheDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'D': 
				return 'Débito'; 
			case 'C': 
				return 'Crédito'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Débito': 
				return 'D'; 
			case 'Crédito': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

}