// Declaração do trigger que é executado antes da atualização de registros da tabela Opportunity.
trigger TriggerOpportunity1 on Opportunity (before update) {
    
    // Verifica se o trigger é executado antes da atualização.
    // Verifica se a atualização foi uma atualização dos registros.
    if(trigger.Isbefore && trigger.isUpdate){

        // Itera sobre cada oportunidade atualizada pelo trigger.
        for(Opportunity opp : trigger.new){

            // Verifica se o estágio anterior da oportunidade era 'Perdida' e o novo estágio não é 'Perdida'.
            if(trigger.oldMap.get(opp.Id).StageName == 'Perdida' && opp.StageName != 'Perdida'){

                // Adiciona uma mensagem de erro ao campo StageName da oportunidade.
                opp.StageName.addError('Oportunidade perdida, fase não pode ser mais alterada');

            // Verifica se o estágio anterior da oportunidade era 'Contrato Assinado' e o novo estágio não é 'Contrato Assinado'.
            }else if(trigger.oldMap.get(opp.Id).StageName == 'Contrato Assinado' && opp.StageName != 'Contrato Assinado'){

                // Adiciona uma mensagem de erro ao campo StageName da oportunidade.
                opp.StageName.addError('Oportunidade ganha, fase não pode ser mais alterada');
            }
        }
    }
}