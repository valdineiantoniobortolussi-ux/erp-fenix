class FinParcelaReceberDomain {
	FinParcelaReceberDomain._();

	static getEmitiuBoleto(String? emitiuBoleto) { 
		switch (emitiuBoleto) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setEmitiuBoleto(String? emitiuBoleto) { 
		switch (emitiuBoleto) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}