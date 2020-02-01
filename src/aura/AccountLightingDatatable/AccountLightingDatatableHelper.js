({
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            	{label: 'Account Name', fieldName: 'UrlLink__c', type: 'url', typeAttributes: { label: { fieldName: 'Name' } }},
                {label: 'Industry', fieldName: 'Industry', type: 'text'},
                {label: 'Phone', fieldName: 'Phone', type: 'Phone'},
                {label: 'Website', fieldName: 'Website', type: 'url '}
            ]);
        var myAttri = component.get("v.accname");
        var action = component.get("c.getListAccounts");
        action.setParams({
            "name": myAttri
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})