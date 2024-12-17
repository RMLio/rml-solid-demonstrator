# Solid Getter

A Javascript Script executing an authenticated HTTP GET request towards a Community Solid Server

## Setup

````shell
nmp install
````


## Use

````shell
node getResource.js email=[email] password=[password] webId=[webId] oidcIssuer=[oidcIssuer] absoluteURI=[absoluteURI]
````

- email, password, webId and oidcIssuer are the authentication details needed for authentication
on a Community Solid Server using [Client Credentials](https://communitysolidserver.github.io/CommunitySolidServer/7.x/usage/client-credentials/). 
- absoluteURI is the URI of the resource to be retrieved from the Solid pod/ 


