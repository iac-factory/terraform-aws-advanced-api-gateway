console.debug("[Debug]", "Lambda Initialization Time", "(" + Date.now() + ")");
module.exports.handler = async (event, context) => {
    console.trace("[Trace] Invocation Context" + ":", JSON.stringify(context));

    return new Promise((resolve) => {
        resolve({
            statusCode: 200,
            headers: {
                "Content-Type": "Application/JSON"
            },
            body: JSON.stringify({
                message: "Awaiting Code Deployment..."
            }, null, 4)
        });
    });
};
