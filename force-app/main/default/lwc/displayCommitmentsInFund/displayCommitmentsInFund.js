import { LightningElement, wire, api, track } from 'lwc';
import getCommitments from '@salesforce/apex/VCFundUtility.getCommitments';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DisplayCommitmentsInFund extends LightningElement {
    @api recordId;
    @track commitmentList;
    @track isLoading = false;
    @track columns = [
        {
            label : 'Name',
            type: 'button',
            initialWidth: 100, 
            typeAttributes: {
                label: {fieldName: 'Name'},
                name: 'openrecord',
                variant: 'base'
            }
        },
        {
            label : 'Owner',
            type: 'button',
            initialWidth: 100, 
            typeAttributes: {
                label: {fieldName: 'FinServ__PrimaryOwner__c'},
                name: 'openrecord',
                variant: 'base'
            }
        },
        {
            label : 'Target Limit',
            initialWidth: 400, 
            fieldName : 'FinServ__TargetLimit__c',
            type: 'currency',
            sortable : true,
            wrapText: true,
            cellattribue : {alignment : 'left'}
        },
        {
            label : 'Balance',
            initialWidth: 180, 
            fieldName : 'FinServ__Balance__c',
            type: 'currency',
            sortable : true,
            wrapText: true,
            cellattribue : {alignment : 'left'}
        },
        {
            label : 'Status',
            initialWidth: 400, 
            fieldName : 'FinServ__Status__c',
            type: 'String',
            sortable : true,
            wrapText: true,
            cellattribue : {alignment : 'left'}
        }
    ]

    //Called when LWC is loaded
    connectedCallback(){
        this.isLoading = true;
        getCommitments({fundId : this.recordId})
            .then(result=>{
                this.commitmentList = result;
                this.isLoading = false;
            })
            .catch(error=>{
                this.isLoading = false;

                // UI API read operations return an array of objects
                if (Array.isArray(error.body)) {
                    this.error = error.body.map(e => e.message).join(', ');
                } 
                // UI API write operations, Apex read and write operations 
                // and network errors return a single object
                else if (typeof error.body.message === 'string') {
                    this.error = error.body.message;
                }

                this.dispatchEvent(new ShowToastEvent({
                    title: 'ERROR',
                    message: this.error,
                    variant: 'ERROR'
                }));
            }
        );

    }

    openAccount(event){
        const row = event.detail.row;
        const recordId = row.FinServ__PrimaryOwner__c;

        this[NavigationMixin.Navigate]({      //LWC Function to open a record. 
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }

    openCommitment(event){
        const row = event.detail.row;
        const recordId = row.FinServ__PrimaryOwner__c;

        this[NavigationMixin.Navigate]({      //LWC Function to open a record. 
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'FinServ__FinancialAccount__c',
                actionName: 'view'
            }
        });
    }
}