const jwt = require("jsonwebtoken");

console.debug("[Debug]", "Lambda Initialization Time", "(" + Date.now() + ")");

/***
 *
 * @param event {import("@types/aws-lambda").APIGatewayAuthorizerEvent}
 * @param context {import("@types/aws-lambda").Context}
 *
 * @returns {Promise<{policyDocument: {Version: string, Statement: [{Action: string, Resource: string, Effect: string}]}, context: *, principalId: *}>}
 */
module.exports.handler = (event, context) => {
    console.trace("[Trace] Invocation Context" + ":", JSON.stringify(context));

    console.log(event);

    const token = event.authorizationToken.split( " ").pop();

    try {
        const claims = jwt.verify( token, process.env.SECRET );
        const policy = generate( claims.sub, event.methodArn );

        return new Promise((resolve) => {
            resolve({
                ...policy,
                context: claims
            });
        });
    } catch ( error ) {
        console.error( error );

        throw "Unauthorized";
    }
}

// By default, API Gateway authorizations are cached (TTL) for 300 seconds.
// This policy will authorize all requests to the same API Gateway instance where the
// request is coming from, thus being efficient and optimising costs.
const generate = (principal, arn) => {
    const wildcard = arn.split( "/", 2 ).join( "/" ) + "/*";

    return {
        principal,
        policyDocument: {
            Version: "2012-10-17",
            Statement: [
                {
                    Action: "execute-api:Invoke",
                    Effect: "Allow",
                    Resource: wildcard
                }
            ]
        }
    };
};