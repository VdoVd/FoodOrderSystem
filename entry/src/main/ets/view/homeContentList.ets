import { content } from '../common/model'

@Component
export default struct homeContentList{
  @Prop
  arr:content[]
  build() {
    Grid(){
      ForEach(this.arr,(item:content)=>{

        GridItem(){
          Column(){
            Image(item.imgPath)
              .width('40%')
            Text(item.title).width('100%')
              .textAlign(TextAlign.Center)
              .fontSize(14)
          }
        }

      })
    }.rowsTemplate('1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
    .columnsGap(13)
    .rowsGap(13)
    .height('22%')
    .padding(20)
  }

}