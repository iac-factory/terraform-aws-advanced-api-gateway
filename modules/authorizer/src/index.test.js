/**
 * @jest-environment node
 */

const JWT = require("jsonwebtoken");

describe( "JWT Generation", function Generate () {
    it( "Generates a JWT Token via Secret Environment Variable", async function () {
        await import("dotenv/config");

        const payload = {
            principal: "Test-Principal"
        };

        const fields = {
            issuer:    "Internal",
            expiresIn: "1d",
            algorithm: "HS256",
            encoding:  "utf-8",
            header:    {
                alg: "HS256",
                typ: "JWT",
                cty: "Application/JWT"
            }
        };

        const signature = JWT.sign(payload, process.env.SECRET, fields);

        console.debug("JWT Token" + ":", signature);

        expect( signature ).toBeTruthy();
    } );
} );
