class FolhaLancamentoCabecalhoDomain {
	FolhaLancamentoCabecalhoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'Folha Mensal'; 
			case '1': 
				return 'Rescisão'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Folha Mensal': 
				return '0'; 
			case 'Rescisão': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}