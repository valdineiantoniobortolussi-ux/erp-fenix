class FinNaturezaFinanceiraDomain {
	FinNaturezaFinanceiraDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'R': 
				return 'Receita'; 
			case 'D': 
				return 'Despesa'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Receita': 
				return 'R'; 
			case 'Despesa': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

}