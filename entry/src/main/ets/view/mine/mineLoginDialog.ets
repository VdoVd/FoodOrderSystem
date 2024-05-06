import { router } from '@kit.ArkUI'

@CustomDialog
export struct mineLoginDialog{
  dialog:CustomDialogController

  build() {

    Column({space:10}){
          Text('您还未登陆，立即登陆？')
            .textAlign(TextAlign.Center)
            .width('100%')
            .fontSize(18)
      Text('请登录后进行访问')
        .fontColor(Color.Gray)
        .fontSize(15)
        .textAlign(TextAlign.Center)
        .width('100%')

      Row(){

        Text('取消')
          .fontSize(18)
          .width('50%')
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            this.dialog.close()
          })

        Text('确定')
          .fontSize(18)
          .fontColor(Color.Blue)
          .width('50%')
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            this.dialog.close()
            router.pushUrl({
              url:"pages/LoginPage"
            })
          })

      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

    }.width('70%')
    .padding(20)

  }

}