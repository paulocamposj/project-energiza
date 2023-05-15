// Declaração do trigger que é executado antes da atualização de registros da tabela Opportunity.
trigger TriggerOpportunity on Opportunity (before update) {
    
    // Verifica se o trigger é executado antes da atualização.
    // Verifica se a atualização foi uma atualização dos registros.
    if(trigger.isBefore && trigger.isUpdate){
        
        // Declara uma lista vazia de tarefas para serem criadas.
        List<Task> task = new List<Task>();
        
        // Itera sobre cada oportunidade atualizada pelo trigger.
        for(Opportunity opp : trigger.new){
            
            // Verifica se o valor da oportunidade é maior que 10000 e se a oportunidade está em um estágio de conclusão.
            if(opp.Amount > 10000 && opp.StageName == 'Contrato Assinado'){
                
                // Cria uma nova tarefa associada à oportunidade, definindo seu assunto e data de atividade.
                Task t =  new Task(
                    WhatId = opp.Id,
                    Subject = 'Um time de profissionais deve ser designado para o cliente',
                    ActivityDate = Date.today().addDays(5)
                );
                
                // Adiciona a tarefa criada à lista de tarefas.
                task.add(t);
            }
        }
        
        // Verifica se há tarefas na lista.
        if(task.size() > 0){
            
            // Insere as tarefas na tabela Task no banco de dados.
            Insert task;
        }    
    }
}