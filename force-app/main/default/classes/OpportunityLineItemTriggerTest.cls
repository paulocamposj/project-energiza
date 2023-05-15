// Indica que esta classe é um conjunto de testes
@isTest
public class OpportunityLineItemTriggerTest {
    
    // Método de teste para verificar se um OpportunityLineItem cria uma tarefa relacionada quando inserido
    @isTest
    public static void testaTerefa(){
        
        // Cria uma nova oportunidade com alguns campos preenchidos
        Opportunity opp =  new Opportunity(
            Name = 'LEO',
            CloseDate = date.today(),
            StageName = 'Identificado',
            CNPJ__c = '37.246.234/0001-23'
        );
        
        // Insere a oportunidade criada
        Insert opp;
        
        // Cria um novo OpportunityLineItem vinculado à oportunidade criada e com alguns campos preenchidos
        OpportunityLineItem oppl = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Product2Id = '01uDo000000VNhLIAW',
            UnitPrice = 0,
            Quantity = 2
        );
        
        // Inicia o bloco de teste
        Test.startTest();
        
        // Insere o OpportunityLineItem criado
        Insert oppl;
        
        // Finaliza o bloco de teste
        Test.stopTest();
        
        // Consulta por tarefas relacionadas à oportunidade criada, limitando a um registro
        List<Task> task = [SELECT WhatId FROM Task WHERE WhatId =: opp.Id LIMIT 1];
        
        // Verifica se exatamente uma tarefa foi encontrada e que o campo WhatId dessa tarefa é igual ao ID da oportunidade criada
        System.assertEquals(1, task.size());
        System.assertEquals(opp.Id, task[0].WhatId);
    }
}