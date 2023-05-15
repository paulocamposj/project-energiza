// Declaração do trigger que é executado antes da atualização de registros da tabela Lead.
trigger TriggerLead on Lead (after update) {
    
    // Verifica se o trigger é executado antes da atualização.
    // Verifica se a atualização foi uma atualização dos registros.
    if(trigger.IsAfter && trigger.IsUpdate){

        // Declara uma lista vazia de tarefas para serem criadas.
        List<Task> task = new List<Task>();

        // Itera sobre cada lead atualizado pelo trigger.
        for(Lead lead : trigger.new){

            // Verifica se o status anterior do lead era 'Contactado' e se o novo status é 'Em Negociação'.
            if(trigger.oldMap.get(lead.Id).Status == 'Contactado' && lead.Status == 'Em Negociação'){

                // Cria uma nova tarefa associada ao lead, definindo seu assunto e data de atividade.
                Task t =  new Task(
                    WhoId = lead.Id,
                    Subject = 'Tentar a conversão nos próximos 10 dias',
                    ActivityDate = Date.today().addDays(10)
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