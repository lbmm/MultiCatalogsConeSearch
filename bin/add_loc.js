use ASDC_catalogs; 

function addLocField(){
    db.fava.find().forEach(function(doc){
         db.fava.update({_id:doc._id}, {$set:{"loc":{'type' : "Point" , 'coordinates' : [(doc.RA -180) ,doc.Dec]}}});
});
};

addLocField();

db.fava.ensureIndex({loc : "2dsphere"})
