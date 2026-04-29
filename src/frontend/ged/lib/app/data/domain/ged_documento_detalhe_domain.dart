class GedDocumentoDetalheDomain {
	GedDocumentoDetalheDomain._();

	static getPodeExcluir(String? podeExcluir) { 
		switch (podeExcluir) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setPodeExcluir(String? podeExcluir) { 
		switch (podeExcluir) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPodeAlterar(String? podeAlterar) { 
		switch (podeAlterar) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setPodeAlterar(String? podeAlterar) { 
		switch (podeAlterar) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAssinado(String? assinado) { 
		switch (assinado) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setAssinado(String? assinado) { 
		switch (assinado) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}