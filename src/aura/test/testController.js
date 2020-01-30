({
    getAccounts : function(component, event) {

        var myAttri = component.get("v.accname");
        var action = component.get("c.getListAccounts");
        action.setParams({
            "name": myAttri
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
        });
       
        $A.enqueueAction(action);
    }

})