import { content, messType } from './model'

export const homeList:content[]=[
  {title:'外卖',imgPath:$rawfile('static/icon/baozizhoupu.png')},
  {title:'本地商超',imgPath:$rawfile('static/icon/bendishangchao.png')},
  {title:'同城服务',imgPath:$rawfile('static/icon/hanbaopisa.png')},
  {title:'拼团',imgPath:$rawfile('static/icon/zhoubian.png')},
  {title:'周边商超',imgPath:$rawfile('static/icon/shangchangbianli.png')},
  {title:'包子粥铺',imgPath:$rawfile('static/icon/baozizhoupu.png')},
  {title:'简餐便当',imgPath:$rawfile('static/icon/jiancanbiandang.png')},
  {title:'日韩料理',imgPath:$rawfile('static/icon/rihanliaoli.png')},
  {title:'汉堡披萨',imgPath:$rawfile('static/icon/hanbaopisa.png')},
  {title:'面包蛋糕',imgPath:$rawfile('static/icon/mianbaodangao.png')},
  {title:'饺子混沌',imgPath:$rawfile('static/icon/jiaozihundun.png')},
  {title:'商场便利',imgPath:$rawfile('static/icon/shuiguo.png')},
  {title:'水果',imgPath:$rawfile('static/icon/meishidacan.png')},
  {title:'甜点饮品',imgPath:$rawfile('static/icon/waimaiyuding.png')},
  {title:'美食大餐',imgPath:$rawfile('static/icon/bendishangchao.png')}
]

export const messList:messType[]=[
  {title:'订单通知',intro:'水煮鱼小碗米饭，雪碧已接单',sec:'07:20',time:'晚上'},
  {title:'小甜甜',intro:'能和心爱的人一起睡觉，是件幸福的事情...',sec:'07:20',time:'晚上'},
  {title:'大柱子',intro:'想要这样一间小木屋，夏天挫冰吃瓜，冬...',sec:'07:20',time:'晚上'},
  {title:'信阳烧烤',intro:'烤炉模式的城，到黄昏，如同打翻的调色...',sec:'07:20',time:'晚上'},
]

export interface  responseLogin{
  code:number
  msg:string
  success:boolean
}