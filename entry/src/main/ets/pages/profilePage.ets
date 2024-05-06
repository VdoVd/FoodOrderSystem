@Entry
@Component
struct profilePage {

  @State avatar:Resource=$rawfile('static/money.svg')
  @State nickName:string='未登录'
  @State areaName:string='北京-北京-东城区'
  @State mono:string='爱你一万年'
  @State address:string=''
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

      Button('保存').width('90%')
        .onClick(()=>{

        })
    }.title('个人信息')
    .titleMode(NavigationTitleMode.Mini)
  }

}