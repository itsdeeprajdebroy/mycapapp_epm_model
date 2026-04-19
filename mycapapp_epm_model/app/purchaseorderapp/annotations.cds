using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI: {
        SelectionFields  : [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_code,
            PARTNER_GUID.COMPANY_NAME
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.boost',
                Label : 'Boost',
                Inline : true,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
                Criticality: Criticality
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order',
            TypeNamePlural : 'Purchase Orders',
            Title:{
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            Description : {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            ImageUrl:'https://images.icon-icons.com/2389/PNG/512/sap_logo_icon_144911.png'
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'More Details',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : '@UI.Identification',
                        Label : 'More Info',
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : '@UI.FieldGroup#fieldgroup1',
                        Label : 'Prices',
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : '@UI.FieldGroup#fieldgroup2',
                        Label : 'Status',
                    },
                ],
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'PO Items',
                Target : 'Items/@UI.LineItem',
            },
        ],
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            },
        ],
        FieldGroup #fieldgroup1 : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
            ],
        },
        FieldGroup #fieldgroup2 : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_code,
                },
                {
                    $Type : 'UI.DataField',
                    Value : LIFECYCLE_STATUS,
                },
                {
                    $Type : 'UI.DataField',
                    Value : OVERALL_STATUS,
                },
            ],
        },
    },

    Common.DefaultValuesFunction : 'getOrderStatusDef'

);

annotate service.POitems with @(

    UI : { 
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.Description,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title : {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            Description : {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.Description,
            },
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'More Infos on Items',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Items Details',
                        Target : '@UI.Identification',
                    },
                ],
            },
        ],
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
     },

);


annotate service.POs with {
    PARTNER_GUID @(
        Common: {
            Text : PARTNER_GUID.COMPANY_NAME,
            // Attaching F4 created - for BP
            ValueList.entity: 'service.BusinessPartnerSet'
        }
    )
};

annotate service.POitems with {
    PRODUCT_GUID @(
        Common: {
            Text : PRODUCT_GUID.Description,
            // Attaching F4 created - for Product
            ValueList.entity: 'service.ProductView'
        }
    )
};

// F4 created BusinessPartnerSet
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI: {
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : COMPANY_NAME,
            },
        ],
    }
);


// F4 created ProductView
@cds.odata.valuelist
annotate service.ProductView with @(
    UI: {
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : Description,
            },
        ],
    }
);


annotate service.POs with {
    PO_ID @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'POs',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PO_ID,
                    ValueListProperty : 'PO_ID',
                },
            ],
            Label : 'PO ID',
        },
        Common.ValueListWithFixedValues : false,
)};

