import { profileUrl } from '../common/exportUrl'
import { allResponse, reqProfile } from '../common/model'
import { httpReq, savePerson } from '../common/req'
import { promptAction, router } from '@kit.ArkUI'

@CustomDialog
struct dialog{
  @Link nickName:string
  @Link area:string
  @Link monitor:string
  @Link address:string
  controller:CustomDialogController
  build() {
    Column(){
      Row(){
        Text('昵称')
      TextInput({placeholder:'输入昵称',text:$$this.nickName}).layoutWeight(1)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('地区')
        TextInput({placeholder:'输入地区',text:$$this.area}).layoutWeight(1)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('个性')
        TextInput({placeholder:'输入个性',text:$$this.monitor}).layoutWeight(1)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('地址信息')
        TextInput({placeholder:'输入地址信息',text:$$this.address}).layoutWeight(1)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      Button('保存')
        .onClick(async ()=>{

          console.log('save start')

          const res1= await savePerson(this.nickName,this.area,this.monitor,this.address)

          const res =await httpReq.post<allResponse<string>>(profileUrl,{
            nickName:this.nickName,
            area:this.area,
            monitor:this.monitor,
            address:this.address,
            token:httpReq.user.token
          } as reqProfile)
          console.log(`res is:${JSON.stringify(res)}`)
          if(res.success===true)
          {
            promptAction.showToast({
              message:'请求成功'
            })
            this.controller.close()
            router.back()
          }else{
            promptAction.showToast({
              message:'请求失败'
            })
            this.controller.close()

          }
        })
    }.padding(20)
  }
}

@Entry
@Component
struct profilePage {

  @State avatar:Resource=$rawfile('static/money.svg')
  @State nickName:string='未登录'
  @State areaName:string='北京-北京-东城区'
  @State mono:string='爱你一万年'
  @State address:string=''
  controller:CustomDialogController=new CustomDialogController({
    builder:dialog({
      nickName:this.nickName,
      area:this.areaName,
      monitor:this.mono,
      address:this.address
    })
    ,
    alignment:DialogAlignment.Center
  })
  build() {

    Navigation(){

      Row(){

        Text('头像')

        Image(this.avatar).width(50)

      }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({left:15,right:15})

      Row(){
        Text('昵称')
        Text(this.nickName)
      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(15)

      Row(){
        Text('地区')
        Text(this.areaName)
      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(15)

      Row(){
        Text('个性')
        Text(this.mono)
      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(15)

      Row(){
        Text('地址信息')
        Text(this.address)
      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(15)

      Button('编辑').width('90%')
        .onClick(()=>{
          this.controller.open()
        })
    }.title('个人信息')
    .titleMode(NavigationTitleMode.Mini)
  }

}

