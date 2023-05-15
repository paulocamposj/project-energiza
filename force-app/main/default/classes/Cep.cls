// Classe responsável por buscar e atualizar informações de endereço de um lead através do seu CEP
public class Cep {
    
    // Método assíncrono que faz uma chamada para a API ViaCEP para buscar informações de endereço a partir de um CEP fornecido
	// Parâmetros:
	// - cep: String que representa o CEP que será usado na busca de endereço
	// - leadId: ID do lead que terá as informações de endereço atualizadas
	@future (callout=true)
    public static void adicionaEndereco(String cep, ID leadId){
        
        // Verifica se o código está sendo executado em um teste
        if (Test.isRunningTest()) {
            System.debug('IsTest');
        }else{
            if (cep != null) {
                // Faz uma chamada para a API ViaCEP
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
                request.setMethod('GET');
                HttpResponse response = http.send(request);
                
                // Analisa a resposta da API e atualiza os campos relevantes na conta
                if (response.getStatusCode() == 200) {
                    
                    // Converte a resposta em um mapa de objetos
                    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    
                    // Cria um novo lead com as informações atualizadas
                    Lead lead = new Lead(
                        Id = leadId,
                        Street = (String) results.get('logradouro') + '-' + (String) results.get('bairro'),
                        State =  (String) results.get('uf'),
                        City =   (String) results.get('localidade'),
                        Country = 'Brasil'
                    );
                    
                    // Atualiza o lead no Salesforce
                    Update lead;
                }
            }
        }
	}
}