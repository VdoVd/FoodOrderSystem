import { http } from '@kit.NetworkKit'
import { responseLogin, User } from './model'
import { userAuth } from '@kit.UserAuthenticationKit'
import { promptAction } from '@kit.ArkUI'

export const getProvince= async ()=>{
  const res = await http.createHttp().request('https://hmajax.itheima.net/api/province')
  return res
}

export const getCity= async (pname:string)=>{
  const res = await http.createHttp().request(`https://hmajax.itheima.net/api/city?pname=${encodeURIComponent(pname)}`)
  return res
}

export const getArea=(pname:string,cname:string)=>{
  const res =  http.createHttp().request(`https://hmajax.itheima.net/api/area?pname=${encodeURIComponent(pname)}&cname=${encodeURIComponent(cname)}`)
  return res
}

export const getCheck= async (username:string,password:string)=>{
  let result:responseLogin={} as responseLogin
  await http.createHttp()
    .request(`http://192.168.110.1:8000/user/login?username=${username}&password=${password}`)
    .then(res=>{
      console.log(`result is:${res.result}`)
      let code:number=(JSON.parse(res.result.toString()) as responseLogin).code
      console.log(`code is:${code}`)
      if((JSON.parse(res.result.toString()) as responseLogin).code===200)

      result=JSON.parse(res.result.toString()) as responseLogin
      console.log(`return1 is ${result}`)
    })
    .catch((err:Error)=>{
      console.log(`err is:${JSON.stringify(err)}`)
    })
  console.log(`return2 is ${result}`)
  return result
}

export const savePerson= async (nickName:string,area:string,monitor:string,address:string)=>{
  const res = await http.createHttp().request(`http://192.168.110.1:8000/user/profile`,{
    method:http.RequestMethod.POST,
    header:{
      "Content-Type":"application/json"
    },
    extraData:{
      nickName:nickName,
      area:area,
      monitor:monitor,
      address:address
    }
  })
  return res.result
}

export class httpReq{

  static baseUrl:string='http://192.168.110.1:8000'

  static  user:User={} as User

  static async post<T>(url:string,extraData?:object){

    try {
      const req=http.createHttp()

      let options:http.HttpRequestOptions={
        method:http.RequestMethod.POST,
        header:{
          "Content-Type":"application/json"
        },
        expectDataType:http.HttpDataType.OBJECT
      }

      if(extraData){
        options.extraData=extraData
        console.log(`extraData:${JSON.stringify(extraData)}`)
      }

      let token:number=httpReq.user.token

      if(token===undefined){
        console.log('token is null')
      }else if(options.header){
        options.header['Authorization']=`${token}`
      }

      url=httpReq.baseUrl+url
      console.log('before post')
      let res=await req.request(url,options)

      console.log(`get result is ${res.result}`)

      return res.result as T

    } catch (err) {
      promptAction.showToast({message:'网络请求错误'})
      return Promise.reject(err)
    }

  }

  static async get<T>(url:string){

    try {

      const req=http.createHttp()

      let options:http.HttpRequestOptions={
        header:{
          "Content-Type":"application/json"
        },
        expectDataType:http.HttpDataType.OBJECT
      }

      let token:number=httpReq.user.token

      if(token===undefined){
        console.log('token is null')
      }else if(options.header){
        options.header['Authorization']=`${token}`
      }

      url=httpReq.baseUrl+url

      const res = await req.request(url,options)

      let result =res.result

      console.log(`get result is:${JSON.stringify(result)}`)

      return result as T

    } catch (err) {

      promptAction.showToast({message:'网络请求异常'})

      return Promise.reject(err)

    }

  }

}

