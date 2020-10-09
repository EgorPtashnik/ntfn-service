const cds = require('@sap/cds');
const express = require('express');

const { folders } = cds.env;

module.exports = async(o)=>{                //> o = options from CLI

    const app = cds.app = o.app || express()
    cds.emit ('bootstrap',app)              //> before bootstrapping
    app.use (express.static (folders.app))  //> default is ./app

    cds.model = await cds.load (o.from)     //> default is '*'
    if (cds.requires.messaging)   await cds.connect.to('messaging')
    if (cds.requires.db) cds.db = await cds.connect.to('db')
    if (o.in_memory) await cds.deploy(cds.model).to(cds.db,o)
    cds.services = await cds.serve(o).from(cds.model).in(app)

    cds.emit ('served', cds.services)       //> after bootstrapping

    return app.listen (o.port || process.env.PORT || 4004)
}
