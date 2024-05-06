import { http } from '@kit.NetworkKit'
import { responseLogin } from './data'

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
  let result:boolean=false
  await http.createHttp()
    .request(`http://192.168.110.1:8000/user/login?username=${username}&password=${password}`)
    .then(res=>{
      console.log(`result is:${res.result}`)
      let code:number=(JSON.parse(res.result.toString()) as responseLogin).code
      console.log(`code is:${code}`)
      if((JSON.parse(res.result.toString()) as responseLogin).code===200)

      result=true
      console.log(`return1 is ${result}`)
    })
    .catch((err:Error)=>{

      console.log(`err is:${JSON.stringify(err)}`)

    })
  console.log(`return2 is ${result}`)
  return result
}

export const savePerson=(nickName:string,area:string,monitor:string,address:string)=>{
  const res = http.createHttp().request(`http://192.168.110.1:8000/user/profile`,{
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
}

