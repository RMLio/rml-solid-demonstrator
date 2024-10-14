# RML4SOLID VALIDATION

## ELABORATED SCENARIO'S

1. Expose one resource including all properties of all products
2. Expose two resources, dividing the information of all products based on two categories of product properties
3. Expose one resource per product, including all properties of that product
4. Expose two resources per product, dividing the product information  based on two categories of product properties
5. Expose one resource per property per product
6. Expose all above scenario's in one pod (multiple overlapping views over the same data)

These scenario's showcase that our solution offers the needed flexibility to support fine-grained access control.  
The source data en mapping for the scenario's can be inspected in [./manufacturer1/](./manufacturer1/).  
The results of the execution of the mapping can be inspected in the Solid pods: [./testpods/pods/manufacturer1/](./testpods/pods/manufacturer1/).   

## SETUP

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

## TO EXECUTE THE MAPPING

- start testpods

````shell
cd ./testpods
npx @solid/community-server -c @css:config/file.json --seedConfig ./seeded-pod-config.json -f pods/
````

- go to other terminal and start solid-target-helper
````shell
cd ./solid-target-helper-and-testpods
node index.js
````

- go to other terminal and start yarrrml-parser and rmlmapper
````shell
cd ./manufacturer1
echo 'Converting YARRRML mapping to RML mapping...'
../../yarrrml-parser/bin/parser.js -i mapping.yml -m -o mapping.rml.ttl

echo 'Using RML mapping to construct knowledge graph...'
java -jar ../../rmlmapper.jar -m mapping.rml.ttl
````

- Check the generated resources in [./testpods/pods/manufacturer1](./testpods/pods/manufacturer1)

## TODO 

### Yarrrml-parser
- [ ] enable the use of functions in combination with a logical target map (dynamic target)
- [ ] shortcut for solid related dynamic targets?
- [ ] add uri key to authentication (to reuse inside triples map to generate targets)
- [ ] merge
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





