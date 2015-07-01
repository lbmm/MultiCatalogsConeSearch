use ASDC_catalogs; 

function addLocField(){
    db.uhecr.find().forEach(function(doc){
         db.uhecr.update({_id:doc._id}, {$set:{"loc":{'type' : "Point" , 'coordinates' : [(doc.RA -180) ,doc.Dec]}}});
});
};

addLocField();

db.uhecr.ensureIndex({loc : "2dsphere"})
