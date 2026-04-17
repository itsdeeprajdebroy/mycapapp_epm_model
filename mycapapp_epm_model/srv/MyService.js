const cds = require("@sap/cds");

module.exports = (srv) => {
  const { EmployeeSrvSet } = srv.entities;
  const { employees } = cds.entities("anubhav.db.master");

  srv.on("vendorsName", (req) => {
    return `hey ${req.data.name}`;
  });

  srv.on("READ", EmployeeSrvSet, async function (req) {
    // const results = [];
    const tx = cds.tx(req);

    let results = [];

    results.push({
      "nameFirst": "Deepraj Uddin",
      "nameMiddle": null,
      "nameLast": "Laskar",
      "nameInitials": null,
      "sex": "M",
      "language": "E"
    });

    //Top 10 records from DB
    results = await tx.run(SELECT.from(employees).limit(10));

    // If the call has id we will return one object otherwise return 10 objects
    const whereCondition = req.data;

    if (whereCondition.hasOwnProperty("ID")) {
      results = await tx.run(SELECT.from(employees).where(whereCondition));
    }
    return results;
  });
};
