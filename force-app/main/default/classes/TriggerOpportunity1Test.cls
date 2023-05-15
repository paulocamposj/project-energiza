// Indica que esta classe é um conjunto de testes
@isTest 
public class TriggerOpportunity1Test {
    
    // Teste para garantir que uma oportunidade perdida não possa ter sua fase alterada
    @isTest 
    public static void testaFasePerdida(){
        
        // Cria uma nova oportunidade com a fase "Perdida"
        Opportunity opp = new Opportunity(
            Name = 'Maria',
            StageName = 'Perdida',
            CloseDate = date.today(),
            CNPJ__c = '16.075.955/0001-48',
            Description = 'Test'
        );
        
        // Insere a oportunidade no banco de dados
        Insert opp;
        
        // Tenta atualizar a fase da oportunidade para "Contrato Assinado"
        opp = new Opportunity(
            Id = opp.Id,
            StageName = 'Contrato Assinado'
        );
        
        // Verifica se ocorreu uma exceção com a mensagem correta
        try{
            Update opp;
        }catch(DmlException e){
            System.assert(e.getMessage().contains('Oportunidade perdida, fase não pode ser mais alterada'));
        }
    }
    
    // Teste para garantir que uma oportunidade ganha não possa ter sua fase alterada
    @isTest 
    public static void testaFaseGanha(){
        
        // Cria uma nova oportunidade com a fase "Contrato Assinado"
        Opportunity opp = new Opportunity(
            Name = 'Maria',
            StageName = 'Contrato Assinado',
            CloseDate = date.today(),
            CNPJ__c = '16.075.955/0001-48',
            Description = 'Test'
        );
        
        // Insere a oportunidade no banco de dados
        Insert opp;
        
        // Tenta atualizar a fase da oportunidade para "Perdida"
        opp = new Opportunity(
            Id = opp.Id,
            StageName = 'Perdida'
        );
        
        // Verifica se ocorreu uma exceção com a mensagem correta
        try{
            Update opp;
        }catch(DmlException e){
            System.assert(e.getMessage().contains('Oportunidade ganha, fase não pode ser mais alterada'));
        }
    }
}