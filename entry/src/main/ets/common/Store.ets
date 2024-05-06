import { User } from './model'

export  const store=()=>{
  AppStorage.setOrCreate<boolean>('isLogin', false)
  AppStorage.setOrCreate<User>("user", {} as User)
}