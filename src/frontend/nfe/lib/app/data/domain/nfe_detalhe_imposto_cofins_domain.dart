class NfeDetalheImpostoCofinsDomain {
	NfeDetalheImpostoCofinsDomain._();

	static getCstCofins(String? cstCofins) { 
		switch (cstCofins) { 
			case '': 
			case '0': 
				return 'AAA'; 
			case '1': 
				return 'BBB'; 
			case '2': 
				return 'CCC'; 
			default: 
				return null; 
		} 
	} 

	static setCstCofins(String? cstCofins) { 
		switch (cstCofins) { 
			case 'AAA': 
				return '0'; 
			case 'BBB': 
				return '1'; 
			case 'CCC': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}