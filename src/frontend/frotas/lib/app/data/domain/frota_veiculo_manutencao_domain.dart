class FrotaVeiculoManutencaoDomain {
	FrotaVeiculoManutencaoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'P': 
				return 'Preventiva'; 
			case 'C': 
				return 'Corretiva'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Preventiva': 
				return 'P'; 
			case 'Corretiva': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

}