import { mineLoginDialog } from './mineLoginDialog'
import { router } from '@kit.ArkUI'
import { Button } from '@kit.InputKit'
import { responseLogin, User } from '../../common/model'

@Component
export  struct MineView{

  @StorageLink('isLogin') isLogin:boolean=false
  @StorageLink('user') user:User={} as User
  @State avatar:Resource=$rawfile('static/home.svg')
  @State login:boolean=false
  changeLogin(){
    if(this.isLogin){
      this.login=true
    }else{
      this.login=false
    }
  }
  dialog:CustomDialogController=new CustomDialogController({

    builder:mineLoginDialog(),

    alignment:DialogAlignment.Center

  })

  aboutToAppear(): void {

  }

  build() {

    Column({space:15}){

      Row(){

        Row({space:15}){
          Image(this.avatar)
            .width(50)
            .borderRadius(25)

          Column({space:10}){

            Text(this.user===undefined?'未登录':this.user.username)
              .fontColor(Color.White)
              .width('100%')
              .textAlign(TextAlign.Start)

            Text('积分')
              .fontColor(Color.White)
              .width('100%')
              .textAlign(TextAlign.Start)

          }.layoutWeight(1)
        }

        Image($rawfile('static/setting.svg'))
          .width(20)
          .margin({right:20})
          .onClick(()=>{
            router.pushUrl({url:'pages/profilePage'})
          })

      }.alignItems(VerticalAlign.Center)
      .backgroundColor('rgba(0,0,0,0.5)')
      .padding(20)

      Row({space:15}){
        Image($rawfile('static/Star.svg')).width(25)
        Text('我的收藏').fontColor(Color.Gray).fontSize(15)
      }.justifyContent(FlexAlign.Start).padding({left:15,right:15})
      .width('100%')

      Row({space:15}){
        Image($rawfile('static/icon/zhoubian.png')).width(25)
        Text('收货地址').fontColor(Color.Gray).fontSize(15)
      }.justifyContent(FlexAlign.Start).padding({left:15,right:15})
      .width('100%')

      Row({space:15}){
        Image($rawfile('static/order.svg')).width(25)
        Text('安全中心').fontColor(Color.Gray).fontSize(15)
      }.justifyContent(FlexAlign.Start).padding({left:15,right:15})
      .width('100%')

      Row({space:15}){
        Image($rawfile('static/logo.png')).width(25)
        Text('在线客服').fontColor(Color.Gray).fontSize(15)
      }.justifyContent(FlexAlign.Start).padding({left:15,right:15})
      .width('100%')

      if(this.isLogin===false)
      {
        Text('登录')
          .width('100%')
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            router.pushUrl({url:"pages/LoginPage"})
          })

      }else{
        Text('退出登录')
          .onClick(()=>{
            this.isLogin=false
            this.user={} as User
          })
          .width('100%')
          .textAlign(TextAlign.Center)
      }
    }.onAppear(()=>{

      this.dialog.open()

    })
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }

}