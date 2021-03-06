// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/io;
import ballerina/grpc;

endpoint helloWorldBlockingClient helloWorldBlockingEp {
    host: "localhost",
    port: 9090
};

function testUnaryBlockingClient (string name) returns (string) {
    error|string unionResp = helloWorldBlockingEp -> hello(name);
    match unionResp {
        string payload => {
            io:println("Client got response : ");
            io:println(payload);
            return "Client got response: " + payload;
        }
        error err => {
            io:println("Error from Connector: " + err.message);
            return "Error from Connector: " + err.message;
        }
    }
}

function testUnaryBlockingIntClient (int age) returns (int) {
    error|int unionResp = helloWorldBlockingEp -> testInt(age);
    match unionResp {
        int payload => {
            io:println("Client got response : ");
            io:println(payload);
            return payload;
        }
        error err => {
            io:println("Error from Connector: " + err.message);
            return -1;
        }
    }
}

function testUnaryBlockingFloatClient (float salary) returns (float) {
    error|float unionResp = helloWorldBlockingEp -> testFloat(salary);
    match unionResp {
        float payload => {
            io:println("Client got response : ");
            io:println(payload);
            return payload;
        }
        error err => {
            io:println("Error from Connector: " + err.message);
            return -1;
        }
    }
}

function testUnaryBlockingBoolClient (boolean isAvailable) returns (boolean) {
    error|boolean unionResp = helloWorldBlockingEp -> testBoolean(isAvailable);
    match unionResp {
        boolean payload => {
            io:println("Client got response : ");
            io:println(payload);
            return payload;
        }
        error err => {
            io:println("Error from Connector: " + err.message);
            return false;
        }
    }
}


function testUnaryBlockingStructClient (Request req) returns (Response) {
    //Request req = {name:"Sam", age:25, message:"Testing."};
    error|Response unionResp = helloWorldBlockingEp -> testStruct(req);
    match unionResp {
        Response payload => {
            io:println("Client got response : ");
            io:println(payload);
            return payload;
        }
        error err => {
            io:println("Error from Connector: " + err.message);
            return {};
        }
    }
}

struct helloWorldBlockingStub {
    grpc:Client clientEndpoint;
    grpc:ServiceStub serviceStub;
}

function <helloWorldBlockingStub stub> initStub (grpc:Client clientEndpoint) {
    grpc:ServiceStub navStub = {};
    navStub.initStub(clientEndpoint, "blocking", descriptorKey, descriptorMap);
    stub.serviceStub = navStub;
}

struct helloWorldStub {
    grpc:Client clientEndpoint;
    grpc:ServiceStub serviceStub;
}

function <helloWorldStub stub> initStub (grpc:Client clientEndpoint) {
    grpc:ServiceStub navStub = {};
    navStub.initStub(clientEndpoint, "non-blocking", descriptorKey, descriptorMap);
    stub.serviceStub = navStub;
}

function <helloWorldBlockingStub stub> hello (string req) returns (string|error) {
    any|grpc:ConnectorError unionResp = stub.serviceStub.blockingExecute("helloWorld/hello", req);
    match unionResp {
        grpc:ConnectorError payloadError => {
            error e = {message:payloadError.message};
            return e;
        }
        any|string payload => {
            match payload {
                string s => {
                    return s;
                }
                any nonOccurrence => {
                    error e = {message:"Unexpected type."};
                    return e;
                }
            }
        }
    }
}

function <helloWorldBlockingStub stub> testInt (int req) returns (int|error) {
    any|grpc:ConnectorError unionResp = stub.serviceStub.blockingExecute("helloWorld/testInt", req);
    match unionResp {
        grpc:ConnectorError payloadError => {
            error e = {message:payloadError.message};
            return e;
        }
        any|int payload => {
            match payload {
                int s => {
                    return s;
                }
                any nonOccurrence => {
                    error e = {message:"Unexpected type."};
                    return e;
                }
            }
        }
    }
}

function <helloWorldBlockingStub stub> testFloat (float req) returns (float|error) {
    any|grpc:ConnectorError unionResp = stub.serviceStub.blockingExecute("helloWorld/testFloat", req);
    match unionResp {
        grpc:ConnectorError payloadError => {
            error e = {message:payloadError.message};
            return e;
        }
        any|float payload => {
            match payload {
                float s => {
                    return s;
                }
                any nonOccurrence => {
                    error e = {message:"Unexpected type."};
                    return e;
                }
            }
        }
    }
}

function <helloWorldBlockingStub stub> testBoolean (boolean req) returns (boolean|error) {
    any|grpc:ConnectorError unionResp = stub.serviceStub.blockingExecute("helloWorld/testBoolean", req);
    match unionResp {
        grpc:ConnectorError payloadError => {
            error e = {message:payloadError.message};
            return e;
        }
        any|boolean payload => {
            match payload {
                boolean s => {
                    return s;
                }
                any nonOccurrence => {
                    error e = {message:"Unexpected type."};
                    return e;
                }
            }
        }
    }
}

function <helloWorldBlockingStub stub> testStruct (Request req) returns (Response|error) {
    any|grpc:ConnectorError unionResp = stub.serviceStub.blockingExecute("helloWorld/testStruct", req);
    match unionResp {
        grpc:ConnectorError payloadError => {
            error e = {message:payloadError.message};
            return e;
        }
        any|Response payload => {
            match payload {
                Response s => {
                    return s;
                }
                any nonOccurrence => {
                    error e = {message:"Unexpected type."};
                    return e;
                }
            }
        }
    }
}

function <helloWorldStub stub> hello (string req, typedesc listener) returns (error| null) {
    var err1 = stub.serviceStub.nonBlockingExecute("helloWorld/hello", req, listener);
    if (err1 != null && err1.message != null) {
        error e = {message:err1.message};
        return e;
    }
    return null;
}

function <helloWorldStub stub> testInt (int req, typedesc listener) returns (error| null) {
    var err1 = stub.serviceStub.nonBlockingExecute("helloWorld/testInt", req, listener);
    if (err1 != null && err1.message != null) {
        error e = {message:err1.message};
        return e;
    }
    return null;
}

function <helloWorldStub stub> testFloat (float req, typedesc listener) returns (error| null) {
    var err1 = stub.serviceStub.nonBlockingExecute("helloWorld/testFloat", req, listener);
    if (err1 != null && err1.message != null) {
        error e = {message:err1.message};
        return e;
    }
    return null;
}

function <helloWorldStub stub> testBoolean (boolean req, typedesc listener) returns (error| null) {
    var err1 = stub.serviceStub.nonBlockingExecute("helloWorld/testBoolean", req, listener);
    if (err1 != null && err1.message != null) {
        error e = {message:err1.message};
        return e;
    }
    return null;
}

function <helloWorldStub stub> testStruct (Request req, typedesc listener) returns (error| null) {
    var err1 = stub.serviceStub.nonBlockingExecute("helloWorld/testStruct", req, listener);
    if (err1 != null && err1.message != null) {
        error e = {message:err1.message};
        return e;
    }
    return null;
}


public struct helloWorldBlockingClient {
    grpc:Client client;
    helloWorldBlockingStub stub;
}

public function <helloWorldBlockingClient ep> init (grpc:ClientEndpointConfiguration config) {
    // initialize client endpoint.
    grpc:Client client = {};
    client.init(config);
    ep.client = client;
    // initialize service stub.
    helloWorldBlockingStub stub = {};
    stub.initStub(client);
    ep.stub = stub;
}

public function <helloWorldBlockingClient ep> getClient () returns (helloWorldBlockingStub) {
    return ep.stub;
}
public struct helloWorldClient {
    grpc:Client client;
    helloWorldStub stub;
}

public function <helloWorldClient ep> init (grpc:ClientEndpointConfiguration config) {
    // initialize client endpoint.
    grpc:Client client = {};
    client.init(config);
    ep.client = client;
    // initialize service stub.
    helloWorldStub stub = {};
    stub.initStub(client);
    ep.stub = stub;
}

public function <helloWorldClient ep> getClient () returns (helloWorldStub) {
    return ep.stub;
}


const string descriptorKey = "helloWorld.proto";
map descriptorMap =
{
    "helloWorld.proto":"0A1068656C6C6F576F726C642E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22490A075265717565737412120A046E616D6518012001280952046E616D6512180A076D65737361676518022001280952076D65737361676512100A036167651803200128035203616765221E0A08526573706F6E736512120A047265737018012001280952047265737032C7020A0A68656C6C6F576F726C6412430A0568656C6C6F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512430A0774657374496E74121B2E676F6F676C652E70726F746F6275662E496E74363456616C75651A1B2E676F6F676C652E70726F746F6275662E496E74363456616C756512450A0974657374466C6F6174121B2E676F6F676C652E70726F746F6275662E466C6F617456616C75651A1B2E676F6F676C652E70726F746F6275662E466C6F617456616C756512450A0B74657374426F6F6C65616E121A2E676F6F676C652E70726F746F6275662E426F6F6C56616C75651A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C756512210A0A7465737453747275637412082E526571756573741A092E526573706F6E7365620670726F746F33",

    "google.protobuf.wrappers.proto":"0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"

};

struct Request {
    string name;
    string message;
    int age;
}

struct Response {
    string resp;
}