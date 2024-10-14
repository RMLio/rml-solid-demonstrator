# Test Pods

## Features

Setup Solid pod with Community Solid Server to test locally.

## Usage

2. Use Node.js 18.0 or up and execute : 
   ```shell
   npx @solid/community-server -c @css:config/file.json --seedConfig ./seeded-pod-config.json -f pods/
   ```
The configuration of the pods can be altered in this file: (./seeded-pod-config.json)[./seeded-pod-config.json]. 
The content of the pods can be inspected in this folder: (./pods/)[./pods]

For more information about the Community Solid Server see (https://communitysolidserver.githu[b.io/CommunitySolidServer/7.x/usage/starting-server/)[https://communitysolidserver.github.io/CommunitySolidServer/7.x/usage/starting-server/]

### License

This code is copyrighted by [Ghent University – imec](http://idlab.ugent.be/) and
released under the [MIT license](http://opensource.org/licenses/MIT).

