
import * as http from 'http';
import { RequestOptions } from 'http';
import {overPassUrl} from './osm.constants';

const search = async (lat:number, lng:number):Promise<any>=>{
  return new Promise((resolve, reject)=>{

    const payload = `[out:json][timeout:25];\n `+
      ` (\n `+
      `  // node["highway"](around:10,50.95860108424417, -1.4116031499276853);\n`+
      `  way["highway"](around:10,${lat}, ${lng}); \n`+
      `//  relation["highway"](around:10,50.95860108424417, -1.4116031499276853);\n`+
      `);\n`+
      ` out body;\n`+
      `>;\n`+
      `out skel qt;`;
    const options : RequestOptions= {
      method:'POST',
      host: overPassUrl.hostname,
      port:overPassUrl.port,
      path:'/api/interpreter',
      headers: {
        'Content-Length':payload.length,
        'Content-Type':'application/json'
      }
    };

    const req = http.request(options,(res)=>{
      let body = '';
      const status = res.statusCode;
      console.log(`status : ${status}`);
      res.on('data',(chunk)=>{
        body+=chunk;
      });

      res.on('end',()=>{
        console.log(body);
        resolve({
          status ,
          body : JSON.parse(body)
        });
      });

      res.on('error',(err)=>{
        reject(err);
      });
    });

    req.on('error',(err)=>{
      reject({
        status:500,
        err
      });
    });
    console.log(payload);
    req.write(payload);
    req.end();
  });
}


export {
  search
}
