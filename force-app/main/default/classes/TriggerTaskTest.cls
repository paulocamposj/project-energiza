// Indica que esta classe é um conjunto de testes
@isTest public class TriggerTaskTest {
    
    // Teste para garantir que uma tarefa concluída atualiza o status e data de pagamento da despesa associada
    @isTest public static void testDespesa (){
        
        // Cria uma nova despesa com um nome completo
        Despesa__c despesa = new Despesa__c(
            Nome_Completo__c =  'Maria Silva'
        );
        
        // Insere a despesa no banco de dados
        Insert despesa;
            
        // Cria uma nova tarefa associada à despesa
        Task task = new Task(
            WhatId = despesa.Id,
            Subject = 'Test',
            Priority = 'Normal',
            Status = 'Not Started'
        );
        
        // Insere a tarefa no banco de dados
        Insert task;
        
        // Atualiza a tarefa para concluída
        task = new Task(
            Id = task.Id,
            WhatId = task.WhatId,
            Status = 'Completed'
        );
        Update task;
        
        // Recupera a despesa associada à tarefa concluída
        Despesa__c d = [SELECT Status__c, Data_de_Pagamento__c FROM Despesa__c WHERE Id =: task.WhatId];
	        
        // Verifica se o status da despesa foi atualizado para "Pago"
        System.assertEquals('Pago', d.Status__c);
        
        // Verifica se a data de pagamento da despesa foi atualizada para a data atual
        System.assertEquals(date.today(), d.Data_de_Pagamento__c);
    }
}