const WebObj = require("./web_obj.js");
let web3Obj;

function init_web3(provider){
    web3Obj = new WebObj();
    web3Obj.setProvider(provider);
    web3Obj.loadContract();
    //console.log(web3Obj);
}

function getWeb3Obj(){
    return web3Obj;
}

module.exports = {
    init_web3,
    getWeb3Obj
}