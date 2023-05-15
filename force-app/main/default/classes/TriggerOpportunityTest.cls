// Indica que esta classe é um conjunto de testes
@isTest public class TriggerOpportunityTest {
    
	// Indica que este método é um teste
    @isTest public static void testaOpportunity(){
        
        // Cria uma oportunidade para testar
        Opportunity opp = new Opportunity(
        	Name = 'Maria',
            CloseDate = Date.today().addDays(15),
            StageName = 'Prospecting',
            CNPJ__C = '00.000.000/0000-00'
        );
        
        // Insere a oportunidade criado
        Insert opp;
        
        // Atualiza a fase da oportunidade para "Concluída" e valor para 11000
        opp = new Opportunity(
        	Id = opp.id,
            Amount = 11000,
            StageName = 'Contrato Assinado'
        );
        
        // Atualiza a oportunidade
        Update opp;
        
        // Busca o registro da tarefa para a oportunidade associada
        Task task = [SELECT WhatId FROM Task WHERE WhatId =: opp.Id];
        
        // Verifica se foi criada uma tarefa para a oportunidade atualizada
        System.assertEquals(task.WhatId, opp.Id);
    }
}