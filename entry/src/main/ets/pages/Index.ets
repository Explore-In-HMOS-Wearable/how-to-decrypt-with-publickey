import { decryptMessagePromise } from '../rsa/Decrypt'

@Entry
@Component
struct EncryptPage {
  inputText: string = ''
  @State decryptedText: string = ''

  build() {
    Scroll() {
      Column() {
        Text('How to Decrypt With Public Key')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 15})

        Button('Decrypt')
          .width('60%')
          .height(36)
          .margin({ top: 12 })
          .backgroundColor('#1E90FF')
          .fontColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            this.decryptedText = decryptMessagePromise()
          })

        if (this.decryptedText !== '') {
          Text(`Decrypt Text: ${this.decryptedText}`)
            .fontSize(14)
            .fontColor(Color.Grey)
            .margin({ top: 12 })
            .textAlign(TextAlign.Center)
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({ left: 10, right: 10})
      .margin({top: '15%', bottom: '15%'})
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
