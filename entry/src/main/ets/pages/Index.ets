import { homeList } from '../common/data'
import { IResponse, User } from '../common/model'
import { getArea, getCheck, getCity, getProvince } from '../common/req'
import { store } from '../common/Store'
import messContent from '../view/home/messContent'
import homeContentList from '../view/homeContentList'
import { MineView } from '../view/mine/mineView'

AppStore()

@CustomDialog
export struct locationDialog{
  @Link provinceRange:string[]
  @Link cityRange:string[]
  @Link areaRange:string[]
  @Link provinceIndex:number
  @Link cityIndex:number
  @Link areaIndex:number
  @Link province:string
  @Link city:string
  @Link area:string
  controller:CustomDialogController
  build() {
    Column(){
      Row() {
        TextPicker({ range: this.provinceRange ,selected:$$this.provinceIndex})
          .onChange((val:string|string[],index:number|number[])=>{
            this.province=val.toString()
            console.log(`province:${this.province}`)
            console.log(`index:${this.provinceIndex}`)
          })
        TextPicker({ range: this.cityRange,selected:$$this.cityIndex })
          .onChange((val:string|string[],index:number|number[])=>{
            this.city=val.toString()
            console.log(`province:${this.province}`)
            console.log(`index:${this.provinceIndex}`)
          })
        TextPicker({ range: this.areaRange ,selected:$$this.areaIndex})
          .onChange((val:string|string[],index:number|number[])=>{
            this.area=val.toString()
            console.log(`province:${this.province}`)
            console.log(`index:${this.provinceIndex}`)
          })
      }
      Button('close').onClick(()=>{
        this.controller.close()
      })
    }

  }
}

@Entry
@Component
struct Index {



  @State searchVal:string=''

  @State tabSelectIndex:number=0

  @State locationText:string='北京'

  @State provinceRange:string[]=['alice','tom','joy']

  @State cityRange:string[]=['alice','tom','joy']

  @State areaRange:string[]=['alice','tom','joy']

  @State province:string=''
  @Watch('httpReq') @State provinceIndex:number=0
  @State city:string=''
  @Watch('httpReq') @State cityIndex:number=0
  @State area:string=''
  @Watch('httpReq') @State areaIndex:number=0
  @State timeId:number=0
  async onPageShow(): Promise<void> {
    let res = await getProvince()
    console.log(`res:${JSON.stringify(res.result)}`)
    let result = (JSON.parse(res.result.toString()) as IResponse).list
    this.provinceRange = result

    let res2 = await getCity(this.provinceRange[0])
    console.log(`res2:${JSON.stringify(res2.result)}`)
    let result2 = (JSON.parse(res2.result.toString()) as IResponse).list
    this.cityRange = result2

    let res3 = await getArea(this.provinceRange[0], this.cityRange[0])
    console.log(`res3:${JSON.stringify(res3.result)}`)
    let result3 = (JSON.parse(res3.result.toString()) as IResponse).list
    this.areaRange = result3
    this.locationText=this.provinceRange[0]
  }

  private async httpReq() {
    clearTimeout(this.timeId)
    this.timeId=setTimeout(async ()=>{
      await this.getData()
    },300)
  }

  private async getData() {
    let res = await getProvince()
    console.log(`res:${JSON.stringify(res.result)}`)
    let result = (JSON.parse(res.result.toString()) as IResponse).list
    this.provinceRange = result

    let res2 = await getCity(this.provinceRange[this.provinceIndex])
    console.log(`res2:${JSON.stringify(res2.result)}`)
    let result2 = (JSON.parse(res2.result.toString()) as IResponse).list
    this.cityRange = result2

    let res3 = await getArea(this.provinceRange[this.provinceIndex], this.cityRange[this.cityIndex])
    console.log(`res3:${JSON.stringify(res3.result)}`)
    let result3 = (JSON.parse(res3.result.toString()) as IResponse).list
    this.areaRange = result3
    this.locationText=this.areaRange[this.areaIndex]
  }

  @Builder
  tarBarBuilder(title:string,imgPath:Resource,index:number){
    Column({space:5}){

      Image(imgPath)
        .width(18)
        .fillColor(this.tabSelectIndex===index?Color.Blue:Color.Black)

      Text(title)
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontColor(this.tabSelectIndex===index?Color.Blue:Color.Black)

    }
  }
  dialog:CustomDialogController=new CustomDialogController({
    builder:locationDialog({
      provinceRange:this.provinceRange,
      cityRange:this.cityRange,
      areaRange:this.areaRange,
      provinceIndex:this.provinceIndex,
      cityIndex:this.cityIndex,
      areaIndex:this.areaIndex,
      province:this.province,
      city:this.city,
      area:this.area

    })
  })
  build() {
    Column(){
      Tabs(){
        TabContent(){

          this.homeContent()

        }.tabBar(this.tarBarBuilder('首页',$rawfile('static/home.svg'),0))
        TabContent(){

        }.tabBar(this.tarBarBuilder('订单',$rawfile('static/order.svg'),1))
        TabContent(){
          messContent()
        }.tabBar(this.tarBarBuilder('消息',$rawfile('static/messages.svg'),2))
        TabContent(){
          MineView()
        }.tabBar(this.tarBarBuilder('我的',$rawfile('static/user.svg'),3))

      }.barPosition(BarPosition.End)
      .onTabBarClick((val)=>{
        this.tabSelectIndex=val
      })
    }
  }

  @Builder
  homeContent() {
    Scroll(){
      Column({space:10}) {
        Row({space:15}) {
          Row({space:15}){
            Image($rawfile('static/location_fill.svg')).width(15)
              .onClick(()=>{
                this.dialog.open()
              })
            Text(`${this.locationText}`).fontSize(15).fontColor(Color.Gray)
          }
          TextInput({ placeholder: '请输入商家或商品的名称', text: $$this.searchVal }).layoutWeight(1)
        }

        Swiper() {
          ForEach([1, 2, 3], (item: number) => {
            Image($rawfile(`static/swipe${item}.jpg`))
              .width('100%')
              .height(150)
          })
        }
        .autoPlay(true)
        .interval(-1)
        .duration(1000)

        homeContentList({ arr: homeList })

        Image($rawfile('static/ad/1.jpg')).width('100%')

        Row({ space: 13 }) {

          Row({ space: 10 }) {
            Image($rawfile('static/money.svg')).width(10)

            Text('领取优惠卷').fontColor(Color.Gray).fontSize(13)

            Text('优惠不停').fontColor(Color.Gray).fontSize(13)
          }

          Text('立即进入').fontColor(Color.Gray).fontSize(13)

        }
        .width('100%')
        .backgroundColor('rgb(238,230,133)')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(13)

        Text('优选推荐').textAlign(TextAlign.Start).width('100%').fontWeight(FontWeight.Bolder).fontSize(20)

        Row() {
          ForEach([1, 2, 3, 4], (item: number) => {
            Image($rawfile(`static/ad/a${item}.jpg`)).width('25%')
          })
        }

        Image($rawfile('static/ad/2.jpg')).width('100%')

        Text('----推荐商家----').width('100%').textAlign(TextAlign.Center).fontSize(15).fontColor(Color.Gray)


      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
  }
}

function AppStore() {
  store()
}
