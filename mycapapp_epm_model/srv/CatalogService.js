const cds = require("@sap/cds");

module.exports = cds.service.impl(async function (srv) {
  
  const { EmployeeSet, POs } = srv.entities;

  srv.after('READ', POs, (results) => {

     results.forEach(po => {

      switch (po.OVERALL_STATUS) {

        case 'P':
          po.OVERALL_STATUS = 'PENDING';
          po.Criticality = 2; // Warning (Yellow)
          break;

        case 'D':
          po.OVERALL_STATUS = 'DISCONTINUED';
          po.Criticality = 3; // Error (Red)
          break;

        default:
          po.OVERALL_STATUS = 'UNKNOWN';
          po.Criticality = 0; // Neutral (Grey)
      }

    });

  });

  srv.before("UPDATE", EmployeeSet, function (req) {
    if (parseFloat(req.data.salaryAmount) > 10000000) {
      req.error(500, "Please edit the amount and update again");
    }
  });

  srv.on("boost", async function (req) {
    try {
      const ID = req.params[0];

      const tx = cds.tx(req);
      // CRUD style API
      await tx.update(POs).where(ID).with({
        GROSS_AMOUNT: { "+=": 20000 },
      });
    } catch (error) {
      return error.toString();
    }
  });

  srv.on("getOrderStatusDef", async function (req) {
    return { OVERALL_STATUS: 'P' }
  });

  srv.on("largestOrder", async function (req) {
    try {
      const ID = req.params[0];
      const tx = cds.tx(req);

      // We will sort POs data in Desc and get the top most -- CRUD style API
      const response = await tx.read(POs).orderBy("GROSS_AMOUNT desc").limit(1);
      return response;

      /**
       * await tx.run(
        SELECT.from(POs).orderBy({GROSS_AMOUNT : 'desc'}).limit(1)
        
      );  
    */
    } catch (error) { }
  });
});
