// Indica que esta classe é um conjunto de testes
@isTest public class TriggerLeadTest {
	
    // Indica que este método é um teste
    @isTest public static void testaLead(){
        
        // Cria um lead para testar
        Lead lead = new Lead(
        	LastName = 'Maria',
            Company = 'LTDA',
            Status = 'Contactado',
            Email = 'maria@gmail.com',
            TipoDeEnergiaSolicitada__c = 'Energia Solar',
            PostalCode = '01001-000'
        );
        
        // Insere o lead criado
        Insert lead;
        
        // Atualiza o status do lead para "Em Negociação"
        lead = new Lead(
        	Id = lead.id,
            Status = 'Em Negociação'
        );
        
        // Atualiza o lead
        Update lead;
        
        // Busca o registro da tarefa para o lead associado 
        Task task = [SELECT WhoId FROM Task WHERE WhoId =: lead.Id];
        
        // Verifica se foi criada uma tarefa para o lead atualizado
        System.assertEquals(task.WhoId, lead.Id);
    }
}