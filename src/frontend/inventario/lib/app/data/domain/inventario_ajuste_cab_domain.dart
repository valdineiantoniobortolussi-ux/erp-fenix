class InventarioAjusteCabDomain {
	InventarioAjusteCabDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'A': 
				return 'Aumentar'; 
			case 'D': 
				return 'Diminuir'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Aumentar': 
				return 'A'; 
			case 'Diminuir': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

}