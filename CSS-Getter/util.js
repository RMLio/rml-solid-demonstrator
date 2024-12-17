import { getAuthenticatedFetch } from "./client-credentials.js";

export async function cli(myFunction) {
    const solidTargetInfo = process.argv.slice(2).reduce((acc, arg) => {
        let [k, v = true] = arg.split('=')
        acc[k] = v
        return acc
    }, {})
    let response = await myFunction(solidTargetInfo);
    let text = await response.text();
    console.log(text);
}

export async function getResource(solidTargetInfo){
    const { email, password, webId, oidcIssuer, absoluteURI } = solidTargetInfo;
    let authFetch = await getAuthenticatedFetch(email, password, oidcIssuer, webId);
    let response = await authFetch(absoluteURI, {
        headers: {
            'accept': 'application/n-quads'
        }
    });
    return response;
}
