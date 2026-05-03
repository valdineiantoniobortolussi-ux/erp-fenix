class WmsRecebimentoCabecalhoDomain {
	WmsRecebimentoCabecalhoDomain._();

	static getInconsistencia(String? inconsistencia) { 
		switch (inconsistencia) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setInconsistencia(String? inconsistencia) { 
		switch (inconsistencia) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}