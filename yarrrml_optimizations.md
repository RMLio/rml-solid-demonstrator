# Possible optimizations in YARRRML

## Shortcut for LT en T triples maps
### Now
````yaml
mappings:
    LT-product-property1:
        sources: products
        s:
          value: LT:product-$(ProductID)-property1
          targets: ThisMapping
        po:
          - [a, rml:LogicalTarget~iri]
          - [rmlt:serialization, formats:Turtle~iri]
          - [rmlt:target, T:product-$(ProductID)-property1~iri]
      T-product-property1:
        sources: products
        s:
          value: T:product-$(ProductID)-property1~iri
          targets: ThisMapping
        po:
          - [a, rmlt:Target~iri]
          - [a, rmli:SolidResourceTarget~iri]
          - [rmli:resource, http://localhost:3000/manufacturer1/product-$(ProductID)-property1]
          - [idsa:userAuthentication, ex:auth/manufacturer1~iri]
    UserAuthentication:
      sources: empty
      s:
        value: ex:auth/manufacturer1
        targets: ThisMapping
      po:
        - [a, idsa:UserAuthentication~iri]
        - [idsa:authUsername, hello@manufacturer1.com]
        - [idsa:authPassword, abc123]
        - [solid:oidcIssuer, http://localhost:3000/~iri]
        - [rmli:webId, http://localhost:3000/manufacturer1/profile/card#me~iri]
````

### Alternative 1
````yaml
targets:
  LT-product-property1:
    sources: products
    uri: LT:product-$(ProductID)-property1
    type: solid_resource
    access: http://localhost:3000/manufacturer1/product-$(ProductID)-property1
    serialization: turtle
    authentication: auth
authentications:
  auth:
    username: hello@manufacturer1.com
    password: abc123
    oidc_issuer: http://localhost:3000/
    web_id: http://localhost:3000/manufacturer1/profile/card#me
````
### Alternative 2
````yaml
dynamic_targets:
  LT-product-property1:
    sources: products
    uri: LT:product-$(ProductID)-property1
    type: solid_resource
    access: http://localhost:3000/manufacturer1/product-$(ProductID)-property1
    serialization: turtle
    authentication: auth
authentications:
  auth:
    uri: some uri #to make it reusabel in a triplesmap, not needed with above shortcut
    username: hello@manufacturer1.com
    password: abc123
    oidc_issuer: http://localhost:3000/
    web_id: http://localhost:3000/manufacturer1/profile/card#me
````
## Functions in logical target map
Needed to avoid url encoding when using a uri from a csv file (access_to in acl.csv)

````yaml
    - targets:
        - function: idlab-fn:concatSequence
          parameters:
          - parameter: rdf:_1
            value: $(access_to)
          - parameter: rdf:_2
            value: _TL
          type: iri
````







