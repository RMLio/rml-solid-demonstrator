# RML4SOLID VALIDATION

## INTRODUCTION

With this repository we demonstrate the capabilities of RML4SOLID. 

We map source data from two manufacturers ([./manufacturer1/](./manufacturer1/) and [./manufacturer2/](./manufacturer2/) and add the resulting data as multiple views over the same data on their Solid pods([./Community_Solid_Server/pods/manufacturer1/](./Community_Solid_Server/pods/manufacturer1/) and [./Community_Solid_Server/pods/manufacturer2/](./Community_Solid_Server/pods/manufacturer2/)). The manufacturers manage the read access to the resources on their Solid pods via a locally stored csv file ([./manufacturer1/read_access.csv](./manufacturer1/read_access.csv) and [./manufacturer2/read_access.csv](./manufacturer2/read_access.csv)). The mapping files of the manufacturers ([./manufacturer1/mapping.yml](./manufacturer1/mapping.yml) and [./manufacturer2/mapping.yml](./manufacturer2/mapping.yml)) also handle the access control files. 

![image](pipeline.jpg “Demo pipeline”)

## MAPPING OF ELABORATED SCENARIO'S TO FUNCTIONAL REQUIREMENTS

### 1. Heterogeneous data source

The source data of manufacturer1 is spread over two files, with heterogeneous file formats ([./manufacturer1/products.csv](./manufacturer1/products.csv) and [./manufacturer1/products2.json](./manufacturer1/products2.json)) with heterogeneous labels (e.g. ProductID and product_id).  

Manufacturer2 has one source file ([./manufacturer2/articles.xml](./manufacturer2/articles.xml)) with his own labels (e.g. articlenumber).

### 2. Semantic interoperability

#### 2.1. Different sources mapped to the same ontology
Manufacturer1 maps source files [./manufacturer1/products.csv](./manufacturer1/products.csv) and [./manufacturer1/products2.json](./manufacturer1/products2.json) to [products](Community_Solid_Server/pods/manufacturer1/products$.ttl).  
Manufacturer2 maps source file [./manufacturer2/articles.xml](./manufacturer2/articles.xml) to [articles](Community_Solid_Server/pods/manufacturer2/articles$.ttl).  
Both manufacturers map their source data to the same ontology. 

#### 2.2. Same sources mapped to two ontologies

Manufacturer1 maps his source data additionally to another ontology: [products-other-ontology](Community_Solid_Server/pods/manufacturer1/products-other-ontology$.ttl).  

### 3. Technical interoperability:

#### 3.1. Read access over HTTP

It is possible to retrieve a resource via a HTTTP get request. (example to be added)  
It is possible to query over multiple resources inside one pod (comunica webclient example to be added)  
It is possible to query over resources located in multiple pods (comunica webclient example to be added)  

### 3.2. Write access over HTTP

No solution for write over HTTP. All writing is handled in the source data. 

### 3.3. Flexible design

#### 3.3.1. Any granularity

The data can be exposed in any granularity. We included following five examples in our setup: 
1. one resource including all properties of all products, e.g. [products](Community_Solid_Server/pods/manufacturer1/products$.ttl)
2. two resources, dividing the information of all products based on two categories of product properties, e.g. [products-a](Community_Solid_Server/pods/manufacturer1/products-a$.ttl)
3. one resource per product, including all properties of that product, e.g. [product-10001](Community_Solid_Server/pods/manufacturer1/product-10001$.ttl)
4. two resources per product, dividing the product information  based on two categories of product properties, e.g. [product-10001-a](Community_Solid_Server/pods/manufacturer1/product-10001-a$.ttl)
5. one resource per property per product  [product-10001-1](Community_Solid_Server/pods/manufacturer1/product-10001-1$.ttl)

#### 3.3.2. Overlapping views
Our demo includes examples of overlapping views: [products](Community_Solid_Server/pods/manufacturer1/products$.ttl), [product-10001](Community_Solid_Server/pods/manufacturer1/product-10001$.ttl), and [product-10001-1](Community_Solid_Server/pods/manufacturer1/product-10001-1$.ttl). 

#### 3.3.3. Disjoint views
Our demo includes examples of disjoint views: [products-a](Community_Solid_Server/pods/manufacturer1/products-a$.ttl) versus [products-b](Community_Solid_Server/pods/manufacturer1/products-b$.ttl), [product-10001](Community_Solid_Server/pods/manufacturer1/product-10001$.ttl) versus [product-10002](Community_Solid_Server/pods/manufacturer1/product-10002$.ttl), [product-10001-1](Community_Solid_Server/pods/manufacturer1/product-10001-1$.ttl) versus [product-10001-2](Community_Solid_Server/pods/manufacturer1/product-10001-2$.ttl).   

## 4. Access control 

The manufacturers manage the read access to the resources on their Solid pods via a locally stored csv file ([./manufacturer1/read_access.csv](./manufacturer1/read_access.csv) and [./manufacturer2/read_access.csv](./manufacturer2/read_access.csv)). This data is mapping to ACL files for resources in their Solid pods. 

RML4SOLID offers the needed flexibility (see 3.3.) to support fine-grained access control.    


## SETUP OF THE DEMO

- install YARRRML parser 
````shell
git clone git@gitlab.ilabt.imec.be:yarrrml/yarrrml-parser.git
cd yarrrml-parser
git checkout target-extensions
npm install
cd ../
````
- install rmlmapper
````shell
git clone git@gitlab.ilabt.imec.be:rml/proc/rmlmapper-java.git
cd rmlmapper-java
git checkout solid-target-dynamic-target
mvn -Pno-buildnumber -DskipTests package
mv $(readlink -f target/rmlmapper-*-all.jar) ../rmlmapper.jar
cd ../
rm -rf rmlmapper-java
````
- install SolidTargetHelper
````shell
git clone git@gitlab.ilabt.imec.be:rml/util/solid-target-helper-and-testpods.git
cd solid-target-helper-and-testpods
git checkout v0.0.1
npm install
cd ../
````


## EXECUTE OF THE DEMO PIPELINE

- start testpods

````shell
cd ./Community_Solid_Server
npx @solid/community-server -c @css:config/file.json --seedConfig ./seeded-pod-config.json -f pods/
````
At question: Ok to proceed > y

- go to other terminal and start solid-target-helper
````shell
cd ../solid-target-helper-and-testpods
node index.js
````

- go to other terminal and start yarrrml-parser and rmlmapper
````shell
cd ../manufacturer1
echo 'Executing mapping manufacturer1...'
../yarrrml-parser/bin/parser.js -i mapping.yml -m -o mapping.rml.ttl
java -jar ../rmlmapper.jar -m mapping.rml.ttl

cd ../manufacturer2
echo 'Executing mapping manufacturer2...'
../yarrrml-parser/bin/parser.js -i mapping.yml -m -o mapping.rml.ttl
java -jar ../rmlmapper.jar -m mapping.rml.ttl
````

- Check the generated resources in [./Communicty_Solid_Server/pods/manufacturer1/](Community_Solid_Server/pods/manufacturer1/) and [./Communicty_Solid_Server/pods/manufacturer2/](Community_Solid_Server/pods/manufacturer2/).

## TODO 

### Yarrrml-parser
- [ ] enable the use of functions in combination with a logical target map (dynamic target)
- [ ] shortcut for solid related dynamic targets(?)
- [ ] add uri key to authentication (to reuse inside triples map to generate targets)(?)
- [ ] merge to yarrrml-parser development branch
- [ ] publish on github

### RMLMapper
- [ ] merge Solid related targets (awaiting review)
- [ ] prepare PR for dynamic targets
- [ ] merge dynamic targets
- [ ] publish on github

### Solid-target-helper
- [ ] isolate testpods and VC integration
- [ ] publish on github
- [ ] publish docker of rmlmapper on imec docker account
- [ ] update docker for Onto-DESIDE

### Scenario's
- [ ] make one mapping per scenario, showcasing each scenario separately (manufacturer1 to manufacturer5) + one mapping including all scenario's, showcasing multiple views with overlapping data  (manufacturer 6)

## GOOD TO KNOW
- It is not possible to use the docker solution with Solid Target Helper together with Solid pods hosted on localhost: Solid Target Helper contacts the localhost inside its docker!





