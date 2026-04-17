using { anubhav.db.master } from '../db/datamodel';


service MyService @(path: 'MyService') {

    function vendorsName(name: String) returns String;

    // Custom Entity
    @readonly
    @Capabilities.Deletable: false
    entity EmployeeSrvSet as projection on master.employees;

}
