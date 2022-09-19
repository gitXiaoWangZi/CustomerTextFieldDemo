# CustomerTextFieldDemo
验证码输入框

![61](https://user-images.githubusercontent.com/20807689/190942488-6f26008b-52eb-4238-80d5-90fd0beba920.gif)

1、一个输入框只输入一个数字，输完下一个输入框响应输入下一个数字

2、不可点击输入框手动选择输入哪个，必须按顺序输入
3、删除操作亦如此
4、过程中如果键盘撤销了（代码中有模拟，点击空视图撤销键盘），可点击输入框一栏，自动定位到正确的输入框内
5、输入框一栏居中显示
6、输入完最后一个，拿到完成code进行往后操作


开发过程中，只需初始化时给出单个输入框宽度，输入框之间的间隙，输入框的数量，以及该view在父试图上左右的间隙即可实现居中显示，但是如果长度过长超出屏幕宽度则不会显示
```
lazy var verificationCodeView: VerificationCodeView = {
        let verificationCodeView = VerificationCodeView(frame: CGRect(x: 20, y: 52, width: kScreenWidth - 40, height: 50),space: 10,tfWidth: 50,number: 4,viewWidth: kScreenWidth - 32)
        verificationCodeView.viewDelegate = self
        return verificationCodeView
    }()
```

样式不管是下划线还是方框，可在代码中自己去实现，只是改一下子视图的样式即可，输入框文本的字体大小颜色自不必多说

