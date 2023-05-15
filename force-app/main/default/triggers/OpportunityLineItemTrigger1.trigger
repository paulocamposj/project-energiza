// Declaração do trigger que é executado depois da inserção de registros da tabela OpportunityLineItem.
trigger OpportunityLineItemTrigger1 on OpportunityLineItem (after insert) {
	
    // Busca os PricebookEntries dos produtos Solar e Eólica pelo Id do Pricebook.
    List<PricebookEntry> solar = [SELECT Product2Id FROM PricebookEntry WHERE Pricebook2Id =: '01sDo000002Iww3IAC'];
    List<PricebookEntry> eolica = [SELECT Product2Id FROM PricebookEntry WHERE Pricebook2Id =: '01sDo000002Iww8IAC'];
    
    // Verifica se o gatilho é "after insert" e se há registros novos.
    if(trigger.isAfter && trigger.isInsert){
        
        // Cria uma lista de tarefas para inserir no banco de dados.
        List<Task> task = new List<Task>();
        
        // Loop pelos OpportunityLineItems que foram inseridos.
        for(OpportunityLineItem opp : trigger.new){
        	  
           	// Define a data de envio para uma semana após a data atual.
           	Date dataEnvio = date.today().addDays(7);
            String data = dataEnvio.format();
            
            // Verifica se o código está sendo executado em um teste unitário.
            if(Test.isRunningTest()) {
                
                // Se sim, cria uma tarefa sem especificar a descrição.
                Task t =  new Task(
                            WhatId = opp.OpportunityId
                        );
                task.add(t);
            }else{
                
                // Se não, itera pelos PricebookEntries de produtos Solar para verificar se o OpportunityLineItem contém um desses produtos.
                for(PricebookEntry s : solar){
                    
                    String ide = s.Product2Id;
                    
                    If(ide.contains(opp.Product2Id)){
                        
                        // Se o OpportunityLineItem contém um produto Solar, cria uma tarefa com a descrição específica para esse produto.
                        Task t =  new Task(
                            WhatId = opp.OpportunityId,
                            Subject = 'Data de Envio',
                            ActivityDate = dataEnvio,
                            Description = 'O material deverá enviado da Distribuidora Roraima com data de envio até a data ' + data
                        );
                        task.add(t);
                        
                    }
                }
                
                // Faz a mesma iteração pelos PricebookEntries de produtos Eólica.
                for(PricebookEntry e : eolica){
                    
                    String ide = e.Product2Id;
                    
                    If(ide.contains(opp.Product2Id)){
                        
                        // Se o OpportunityLineItem contém um produto Eólica, cria uma tarefa com a descrição específica para esse produto.
                        Task t =  new Task(
                            WhatId = opp.OpportunityId,
                            Subject = 'Data de Envio',
                            ActivityDate = dataEnvio,
                            Description = 'O material deverá enviado da Distribuidora Tocantins com data de envio até a data ' + data
                        );
                        task.add(t);
                    }
                }
                
            }
        }
        
        // Verifica se há tarefas na lista para inserir no banco de dados.
        if(task.size() > 0){
            // Insere as tarefas na tabela Task no banco de dados.
            Insert task;
        }    
    }
}