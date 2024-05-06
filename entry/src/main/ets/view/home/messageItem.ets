@Component
export default struct messageItem{
  @Prop title:string='订单通知'
  @Prop time:string='晚上'
  @Prop intro:string=''
  @Prop sec:string=''
  build() {

    Row(){
      Column({space:10}){

        Row()
        {
          Text(this.title)
            .layoutWeight(1)

          Text(this.time)
            .fontColor(Color.Gray)

        }.width('100%')

        Row()
        {

          Text(this.intro).layoutWeight(1)

          Text(this.sec)

        }.width('100%')

      }
    }

  }

}