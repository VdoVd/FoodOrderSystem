export interface content{
  title:string
  imgPath:Resource
}

export interface IResponse{
  message:string
  list:string[]
}

export interface messType{
  title:string
  time:string
  intro:string
  sec:string
}

export interface User{
  username:string
  password:string
  token:number
}

export interface  responseLogin{
  code:number
  msg:string
  success:boolean
  token:number
}

export interface allResponse<T>{
  code:number
  msg:string
  success:boolean
  data:T
}

export interface reqProfile{

  nickName:string,
  area:string,
  monitor:string,
  address:string,
  token:number
}
