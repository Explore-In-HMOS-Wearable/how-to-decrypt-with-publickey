import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { util } from '@kit.ArkTS';

export function decryptMessagePromise() {
  let message = "sUAmkWmwpWdAE/xhyv0LssNINi1sglHvKO7H49X/6rHAuVDLeSK4LTbZ3KoVqpB68tav9CkzweL8Fh6cKNuVzza+xAbvbEOmauZMHGgzRwD+2y8/4HLlZPQGpD/5+IdHkVNjjGQyk+wxX+ejKaDCXJtaReTrcTwVwBk8Tl31jEl1iOugpdrTm2kbp9GDrXeGDFoLdk6yy/lT5I5Op8BwOVGTYlkLOkkEtcpv+iGJuCRIPERY+KNtUgEFB9hNF+58zYb34o5htieV4dE3VeCEr3b0/OrokA7ak5oEi+6rZyt6J4kWfH9yMXLO8VoISgxJRdYB4hcKzw/cSoOPWAaG1Q=="
  const base64Helper = new util.Base64Helper();
  const publickey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtbIz1BPk6Rhan8UlK3/3iOYfI96eP+GbBTPGS46c2/Sm3TrdZhIXBVLO2gYK/CuGtRsC68rH9WvINmtsnENd9NfFNKrN4ZfitQHFxLl8ggYx0nCpsyaEXoy0aJEIa2iHG7QEojJpJPLsQjzurfHK93wgiLPUxt2Zp5AfBWnXK6IohGu82oFGp0uzsfUQmjXyigliY47QOMnWUn2VzYabZokJDKYSvN4gm5BwAm+tFCGX7DO7OZ8UGObcTGF+t6KR4PixzB/tYJ1MUulasVBqKiPUhuVjiRqB7XiLSchho+T23bMH4tJWOki630bP5JxamFht2lC+9f1+hoDx3MN0gwIDAQAB"
  let decodedStr = base64Helper.decodeSync(message);
  const rsaGenerator = cryptoFramework.createAsyKeyGenerator('RSA2048')
  let pubKey = base64Helper.decodeSync(publickey)
  let PairKey = rsaGenerator.convertKeySync({data: pubKey},null)
  let data: cryptoFramework.DataBlob = {
    data : decodedStr
  }
  let decryptMessage = DecryptWithPubKey(data,PairKey.pubKey)
  let textDecoder = util.TextDecoder.create('gbk')
  let decodeResult = textDecoder.decodeToString(decryptMessage?.data)
  console.log("DECODE RESULT " +decodeResult)
  return decodeResult
}

function DecryptWithPubKey(message : cryptoFramework.DataBlob,pubKey : cryptoFramework.PubKey){
  let verifyAlg = "RSA2048|PKCS1|NoHash|Recover"
  let verifier = cryptoFramework.createVerify(verifyAlg)
  verifier.initSync(pubKey)
  let rawSignData = verifier.recoverSync(message)
  return rawSignData
}