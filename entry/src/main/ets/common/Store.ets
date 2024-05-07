import { reqProfile, responseProfile, User } from './model'

export  const store=()=>{
  AppStorage.setOrCreate<boolean>('isLogin', false)
  AppStorage.setOrCreate<User>("user", {} as User)
  AppStorage.setOrCreate<responseProfile>("profile",{} as responseProfile)
}