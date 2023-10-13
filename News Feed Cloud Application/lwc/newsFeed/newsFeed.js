import { LightningElement } from 'lwc';
import getnewFeild from '@salesforce/apex/NewsfeedDatail.getnews';
export default class NewsFeed extends LightningElement {

    count= 1;
    fetchNews = ''; 

    connectedCallback(){
        getnewFeild({offset : 1 }).then(result => {        
             this.fetchNews = result;              
         //    console.log(this.fetchNews);
        }).catch(error => {
             console.log('Error occurred : '+error);
        })
    }   

    handleClick(){          
        console.log(this.count++);
        getnewFeild({offset : this.count }).then(result => {        
             this.fetchNews = result;              
           //  console.log(this.fetchNews);
        }).catch(error => {
             console.log('Error occurred : '+error);
        })
    }
}