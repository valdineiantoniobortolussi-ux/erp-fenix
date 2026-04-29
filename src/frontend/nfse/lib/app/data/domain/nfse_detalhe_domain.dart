class NfseDetalheDomain {
	NfseDetalheDomain._();

	static getIssRetido(String? issRetido) { 
		switch (issRetido) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setIssRetido(String? issRetido) { 
		switch (issRetido) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}