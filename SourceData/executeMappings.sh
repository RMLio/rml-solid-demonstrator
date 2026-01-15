cd ./manufacturer1
echo 'Executing mapping manufacturer1...'
docker run --rm -it -v $(pwd)/:/data rmlio/yarrrml-parser:1.10.0 -i /data/mapping.yml -o /data/generated-mapping.rml.ttl
java -jar ../rmlmapper.jar -m generated-mapping.rml.ttl -d
cd ../manufacturer2
echo 'Executing mapping manufacturer2...'
docker run --rm -it -v $(pwd)/:/data rmlio/yarrrml-parser:1.10.0 -i /data/mapping.yml -o /data/generated-mapping.rml.ttl
java -jar ../rmlmapper.jar -m generated-mapping.rml.ttl -d
cd ../manufacturer3
echo 'Executing mapping manufacturer3...'
docker run --rm -it -v $(pwd)/:/data rmlio/yarrrml-parser:1.10.0 -i /data/mapping.yml -o /data/generated-mapping.rml.ttl
java -jar ../rmlmapper.jar -m generated-mapping.rml.ttl -d
cd ../admin
echo 'Executing mapping admin...'
docker run --rm -it -v $(pwd)/:/data rmlio/yarrrml-parser:1.10.0 -i /data/mapping.yml -o /data/generated-mapping.rml.ttl
java -jar ../rmlmapper.jar -m generated-mapping.rml.ttl -d
cd ..