using {anubhav.db} from '../db/datamodel';
using {cappo.cds} from '../db/CDSViews';

service CatalogService @(path: 'CatalogService') {

    entity BusinessPartnerSet               as projection on db.master.businesspartner;
    entity AddressSet                       as projection on db.master.address;
    entity EmployeeSet                      as projection on db.master.employees;

    // Boost action for POs - Adding 20000 on PO if we click
    entity POs @(odata.draft.enabled: true) as
        projection on db.transaction.purchaseorder {
            *,
            case
                OVERALL_STATUS
                when 'A'
                     then 'APPROVED'
                when 'X'
                     then 'REJECTED'
                when 'D'
                     then 'DELEVERED'
                when 'P'
                     then 'PENDING'
            end as OverallStatus : String(10) @(title: '{i18n>OLIFECYCLE_STATUS}'),
            case
                OVERALL_STATUS
                when 'A'
                     then 3
                when 'X'
                     then 1
                when 'D'
                     then 3
                when 'P'
                     then 2
            end as Criticality   : Integer
        }
        actions {
            @cds.odata.bindingparameter.name: '_instance'
            @Common.SideEffects             : {TargetProperties: ['_instance/GROSS_AMOUNT']}
            action   boost();
            function largestOrder() returns POs;
        };

    function getOrderStatusDef() returns POs;

    entity POitems                          as projection on db.transaction.poitems;

    entity ProductView                      as projection on cds.CDSViews.ProductView;

}


/**
 * unbound actions & functions
 *
  function sum (x:Integer, y:Integer) returns Integer;
  function stock (id : Foo:ID) returns Integer;
  action add (x:Integer, to: Integer) returns Integer;
 */

/**
 * bound action , means bound to a entity.
 *
 * entity Foo { key ID:Integer } actions {
 *      action order (x:Integer) returns Integer;
 * }
 */
