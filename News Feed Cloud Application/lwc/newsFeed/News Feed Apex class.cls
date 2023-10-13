public class NewsfeedDatail {
	@AuraEnabled(cacheable=true)
    public static List<newsDetails> getnews(Integer offset) {  
        system.debug(offset);
        DateTime todaysDate = System.today();
        String todaysDateStr = todaysDate.format('yyyy-MM-dd');
        System.debug(todaysDateStr);
        
        Datetime dt = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek=dt.format('EEEE');
        System.debug(todaysDateStr+' ' + dayOfWeek);
        
        Http h = new Http();
   	 
    	HttpRequest request = new HttpRequest();
        request.setTimeout(60000);
   		request.setEndpoint('http://api.mediastack.com/v1/news?access_key=3985336729bcecb11875c150bfb0d31c&languages=en&countries=in&limit=1&offset='+offset+'&date='+todaysDateStr);    	
    	request.setMethod('GET');
   	 
    	HttpResponse response = h.send(request);
        system.debug(response.getStatusCode());
        
        Map<String, Object> jsonBody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        List<Object> jsonList = (List<Object>)jsonBody.get('data');  
        Map<String, Object> insideMap;
        for(Object ob : jsonList){            
            insideMap = (Map<String, Object>)ob;           
        }
                
        List<newsDetails> newsWrapper = new List<newsDetails>();
        
        newsDetails nfd = new newsDetails();
            if(String.valueOf(insideMap.get('author'))== null){
               nfd.author = 'N/A';
            }else{
                nfd.author = String.valueOf(insideMap.get('author'));   
            }            
        nfd.title = String.valueOf(insideMap.get('title'));        
        if(String.valueOf(insideMap.get('image')) == null){
            nfd.image = String.valueOf('https://t3.ftcdn.net/jpg/05/52/37/18/360_F_552371867_LkVmqMEChRhMMHDQ2drOS8cwhAWehgVc.jpg');
        }else{
            nfd.image = String.valueOf(insideMap.get('image'));
        }       
        nfd.urls = String.valueOf(insideMap.get('url'));
        nfd.description = String.valueOf(insideMap.get('description'));   
        nfd.source = String.valueOf(insideMap.get('source'));
        nfd.dates = String.valueOf(todaysDateStr+' ' + dayOfWeek);   
        newsWrapper.add(nfd);
       	system.debug(newsWrapper);
        return newsWrapper;
    }
    
    public class newsDetails{
        @AuraEnabled public String author, title, description, image, urls, source, dates;
    }
}