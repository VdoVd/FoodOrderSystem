import { messList } from '../../common/data'
import { messType } from '../../common/model'
import messageItem from './messageItem'

@Component
export default struct messContent{

  build() {

    Column({space:20}){
      ForEach(messList,(item:messType)=>{
        messageItem({title:item.title,intro:item.intro,sec:item.sec,time:item.time})
          .backgroundColor('rgba(0,0,0,0.1)')
          .padding(20)
          .borderRadius(12)
      })
    }.height('100%')
    .justifyContent(FlexAlign.Start)
    .padding(10)

  }

}