import { LightningElement } from 'lwc';
import getnewFeild from '@salesforce/apex/NewsfeedDetail.getnews';
export default class NewsFeed extends LightningElement {
    statusOptions = [
        { value: 'au', label: 'Australia' },{ value: 'br', label: 'Brazil' },{ value: 'ca', label: 'Canada' },{ value: 'cn', label: 'China' },
        { value: 'eg', label: 'Egypt' }, { value: 'fr', label: 'France' },{ value: 'de', label: 'Germany' },{ value: 'gr', label: 'Greece' },
        { value: 'hk', label: 'Hong Kong' },{ value: 'in', label: 'India' },{ value: 'id', label: 'Indonesia' },{ value: 'il', label: 'Israel' },
        { value: 'it', label: 'Italy' },{ value: 'jp', label: 'Japan' },{ value: 'my', label: 'Malaysia' },{ value: 'mx', label: 'Mexico' },
        { value: 'nl', label: 'Netherland' },{ value: 'nz', label: 'New Zealand' },{ value: 'ph', label: 'Philippine' },{ value: 'sa', label: 'Saudi Arabia' },
        { value: 'sg', label: 'Singapore' },{ value: 'za', label: 'South Africa' },{ value: 'tr', label: 'Turkey' },{ value: 'ae', label: 'UAE' },
        { value: 'ua', label: 'Ukraine' },{ value: 'gb', label: 'United Kingdom' },{ value: 'us', label: 'USA' }
    ];

    count= 1;
    value = 'in';
    fetchNews = ''; 

     handleChange(event) {        
        this.value = event.detail.value;
        console.log(this.value);
    }

    connectedCallback(){        
        getnewFeild({offset : 1 , country : 'in'}).then(result => {        
             this.fetchNews = result;              
         //    console.log(this.fetchNews);
        }).catch(error => {
             console.log('Error occurred : '+error);
        })
    }      

    handleClick(){   
        console.log(this.count++);
        getnewFeild({offset : this.count , country : this.value}).then(result => {        
             this.fetchNews = result;              
           //  console.log(this.fetchNews);
        }).catch(error => {
             console.log('Error occurred : '+error);
        })
    }
}
