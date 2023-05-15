// Declaração do trigger que é executado após a inserção e atualização de registros da tabela Lead.
trigger TriggerCep on Lead (after insert, after update) {
	
    // Verifica se a trigger é "after"
    if(trigger.isAfter){
        // Verifica se a trigger é "after insert"
        if(trigger.isInsert){
            // Loop através dos Leads inseridos em "trigger.new"
            for (Lead lead : trigger.new) {
        		// Chama o método "adicionaEndereco" da classe "Cep", passando o CEP e o ID do Lead como parâmetros
        		Cep.adicionaEndereco(lead.PostalCode, lead.Id);
    		}
        }
        // Verifica se a trigger é "after update"
        else if(trigger.isUpdate) {
        	// Loop através dos Leads atualizados em "trigger.new"
        	for (Lead lead : trigger.new) {
                // Verifica se o CEP foi alterado comparando com o CEP anterior em "trigger.oldMap"
                if(lead.PostalCode != trigger.oldMap.get(lead.Id).PostalCode){
					// Chama o método "adicionaEndereco" da classe "Cep", passando o novo CEP e o ID do Lead como parâmetros
					Cep.adicionaEndereco(lead.PostalCode, lead.Id);                    
                }        		
    		}
    	}
    }
}