sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"sap/dd/purchaseorderapp/test/integration/pages/POsList",
	"sap/dd/purchaseorderapp/test/integration/pages/POsObjectPage",
	"sap/dd/purchaseorderapp/test/integration/pages/POitemsObjectPage"
], function (JourneyRunner, POsList, POsObjectPage, POitemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('sap/dd/purchaseorderapp') + '/test/flp.html#app-preview',
        pages: {
			onThePOsList: POsList,
			onThePOsObjectPage: POsObjectPage,
			onThePOitemsObjectPage: POitemsObjectPage
        },
        async: true
    });

    return runner;
});

