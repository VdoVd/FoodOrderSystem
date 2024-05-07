import { promptAction, router } from '@kit.ArkUI'
import { responseLogin, User } from '../common/model'
import { getCheck, httpReq } from '../common/req'

@Entry
@Component

struct LoginPage {

  @State username:string=''

  @State password:string=''

  @StorageLink('user') obj:User={} as User

  @StorageLink('isLogin') isLogin:boolean=false

  build() {
    Column({space:15}){
        Row(){
          Text('<')
            .fontWeight(FontWeight.Bolder)
            .onClick(()=>{
              router.back()
            })
          Text('登录')
            .fontWeight(FontWeight.Bolder)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }  .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      Row({space:15}){
        Text('账户').fontColor(Color.Gray)
        TextInput({placeholder:'请输入账户',text:$$this.username})
          .layoutWeight(1)
      }
      Row({space:15}){
        Text('密码')
          .fontColor(Color.Gray)
        TextInput({placeholder:'请输入密码',text:$$this.password})
          .layoutWeight(1)
      }
      Button('登录')
        .width('100%')
        .onClick(async ()=>{
          if(this.username===''){
            promptAction.showToast({
              message:'用户名不为空'
            })
          }else if(this.password==''){
            promptAction.showToast({
              message:'密码不为空'
            })
          }else{

            let url= `/user/login?username=${this.username}&password=${this.password}`
            let res:responseLogin=await httpReq.get<responseLogin>(url)
            if(res.success===true)
            {
              promptAction.showToast({
                message:'登录成功'
              })
              setTimeout(()=>{
                this.isLogin=true
                this.obj.username=this.username
                this.obj.password=this.password
                this.obj.token=res.token
                httpReq.user.token=res.token
                httpReq.user.username=this.username
                router.back()
              },1000)
            }else{
              promptAction.showToast({
                message:'登录失败'
              })
            }
          }
        })
    }.padding(20)

  }

}