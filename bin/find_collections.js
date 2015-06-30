use ASDC_catalogs;

var collections_names = db.getCollectionNames();

var database_to_use = "use ASDC_catalogs;";
print(database_to_use);
var declaration = "function addLocField(){"
print(declaration);

for (var i in collections_names){
     var name = collections_names[i];
     if (name.lastIndexOf('system', 0) === 0){
       continue;
       }
     var head = "db." + name + ".find().forEach(function(doc){";
     var body = "db." + name + '.update({_id:doc._id}, {$set:{"loc":{"type" : "Point" , "coordinates" : [(doc.RA -180) ,doc.Dec]}}}); });';
     print(head);
     print(body);

}

print ("};");

print("addLocField();")


for (var i in collections_names){
     var name = collections_names[i];
     if (name.lastIndexOf('system', 0) === 0){
       continue;
       }
     var index = "db." + name+ '.ensureIndex({loc : "2dsphere"});';
     print(index);

     
}
