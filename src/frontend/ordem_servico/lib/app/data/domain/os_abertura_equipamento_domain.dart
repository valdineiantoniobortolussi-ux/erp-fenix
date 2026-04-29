class OsAberturaEquipamentoDomain {
	OsAberturaEquipamentoDomain._();

	static getTipoCobertura(String? tipoCobertura) { 
		switch (tipoCobertura) { 
			case '': 
			case 'N': 
				return 'Nenhum'; 
			case 'G': 
				return 'Garantia'; 
			case 'S': 
				return 'Seguro'; 
			case 'C': 
				return 'Contrato'; 
			default: 
				return null; 
		} 
	} 

	static setTipoCobertura(String? tipoCobertura) { 
		switch (tipoCobertura) { 
			case 'Nenhum': 
				return 'N'; 
			case 'Garantia': 
				return 'G'; 
			case 'Seguro': 
				return 'S'; 
			case 'Contrato': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

}