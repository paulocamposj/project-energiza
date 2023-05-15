// Declaração do trigger que é executado após a atualização de registros da tabela Task.
trigger TriggerTask on Task (after update) {
	
    // Verifica se o trigger é executado após a atualização.
    // Verifica se a atualização foi uma atualização dos registros.
    if(trigger.isAfter && trigger.isUpdate){
        
        // Itera sobre cada objeto Task atualizado pelo trigger.
        for(Task task : trigger.new){
            
            // Verifica se a tarefa foi marcada como concluída.
            if(task.Status == 'Completed'){
                
                // Cria um novo objeto de Despesa e define seus campos.
                Despesa__c despesa = new Despesa__c(
                    Id = task.WhatId,
                    Data_de_Pagamento__c = task.LastModifiedDate.date(),
                    Status__c = 'Pago'
                );
                
                // Atualiza o registro de Despesa no banco de dados.
                Update despesa;
            }
        }
    }
}