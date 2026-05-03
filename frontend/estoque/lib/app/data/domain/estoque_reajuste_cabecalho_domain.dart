class EstoqueReajusteCabecalhoDomain {
	EstoqueReajusteCabecalhoDomain._();

	static getTipoReajuste(String? tipoReajuste) { 
		switch (tipoReajuste) { 
			case '': 
			case 'A': 
				return 'Aumentar'; 
			case 'D': 
				return 'Diminuir'; 
			default: 
				return null; 
		} 
	} 

	static setTipoReajuste(String? tipoReajuste) { 
		switch (tipoReajuste) { 
			case 'Aumentar': 
				return 'A'; 
			case 'Diminuir': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

}