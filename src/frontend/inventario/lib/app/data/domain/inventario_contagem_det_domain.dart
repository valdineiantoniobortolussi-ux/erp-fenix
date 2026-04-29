class InventarioContagemDetDomain {
	InventarioContagemDetDomain._();

	static getFechadoContagem(String? fechadoContagem) { 
		switch (fechadoContagem) { 
			case '': 
			case '01': 
				return '01'; 
			case '02': 
				return '02'; 
			case '03': 
				return '03'; 
			default: 
				return null; 
		} 
	} 

	static setFechadoContagem(String? fechadoContagem) { 
		switch (fechadoContagem) { 
			case '01': 
				return '01'; 
			case '02': 
				return '02'; 
			case '03': 
				return '03'; 
			default: 
				return null; 
		} 
	}

}