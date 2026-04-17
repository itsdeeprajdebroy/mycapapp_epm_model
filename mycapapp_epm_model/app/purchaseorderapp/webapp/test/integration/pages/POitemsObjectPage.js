sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'sap.dd.purchaseorderapp',
            componentId: 'POitemsObjectPage',
            contextPath: '/POs/Items'
        },
        CustomPageDefinitions
    );
});