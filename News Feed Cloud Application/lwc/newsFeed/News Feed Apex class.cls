public class NewsfeedDetail {
	@AuraEnabled(cacheable=true)
    public static List<newsDetails> getnews(Integer offset, string country, string countryName) {  
        system.debug(country);
        system.debug(offset);
        DateTime todaysDate = System.today();
        String todaysDateStr = todaysDate.format('yyyy-MM-dd');
        System.debug(todaysDateStr);
        
        Datetime dt = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek=dt.format('EEEE');
        System.debug(todaysDateStr+' ' + dayOfWeek);
        
        try{
             Http h = new Http();
   	 
                HttpRequest request = new HttpRequest();
                request.setTimeout(60000);
                request.setEndpoint('http://api.mediastack.com/v1/news?access_key=3985336729bcecb11875c150bfb0d31c&languages=en&countries='+country+'&limit=1&offset='+offset+'&date='+todaysDateStr);
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
                    system.debug(String.valueOf(insideMap.get('image')));
                }       
                nfd.urls = String.valueOf(insideMap.get('url'));
                nfd.description = String.valueOf(insideMap.get('description'));   
                nfd.source = String.valueOf(insideMap.get('source'));
                nfd.dates = String.valueOf(todaysDateStr+' ' + dayOfWeek);   
                newsWrapper.add(nfd);
                 return newsWrapper;
        }
        catch(Exception e){
           system.debug(e.getMessage());
           List<newsDetails> NonewsWrapper = new List<newsDetails>();                
           newsDetails noNews = new newsDetails();  
           String day = todaysDate.format('dd');
           String year = todaysDate.format('yyyy');           
		   String dayName = todaysDate.format('EEEE'); 
           noNews.author = 'N/A';
           noNews.image = 'https://img.freepik.com/premium-vector/forbidden-sign-with-news-icon-vector-illustration_601298-2051.jpg?w=360';
           noNews.title = 'No News from '+countryName+' for '+String.valueOf(day + ' '+dayName+ '-' +year)+'...!';
           noNews.source = 'N/A';          
           noNews.urls = 'https://shreyash007-dev-ed--c.develop.vf.force.com/resource/1697606884000/PageNotfound?';   
           noNews.dates = String.valueOf(day + ' '+dayName+ '-' +year);
           NonewsWrapper.add(noNews);
           return NonewsWrapper;
        }       
    }
    
    public class newsDetails{
        @AuraEnabled public String author, title, description, image, urls, source, dates;
    }
}
