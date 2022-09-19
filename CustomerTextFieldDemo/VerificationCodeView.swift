//
//  VerificationCodeView.swift
//  CustomerTextFieldDemo
//
//  Created by 刘圣洁 on 2022/9/17.
//

import UIKit

protocol VerificationCodeViewDelegate {
    func verificationCodeDidFinishedInput(verificationCodeView:VerificationCodeView,code:String)
}

class VerificationCodeView: UIView {

    var textfieldArr : [UITextField] = []
    var space: CGFloat = 10
    var tfWidth: CGFloat = 50
    var number: Int = 6
    var viewWidth: CGFloat
    var viewDelegate: VerificationCodeViewDelegate?
    
    init(frame: CGRect,space: CGFloat = 10,tfWidth: CGFloat = 50,number: Int = 6,viewWidth: CGFloat) {
        self.space = space
        self.tfWidth = tfWidth
        self.number = number
        self.viewWidth = viewWidth
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerificationCodeView {
    
    func setupUI() {
        //验证码view的宽度
        let verificationViewWidth = (space + tfWidth) * CGFloat(number) - space
        let baseLeftX = (kScreenWidth - verificationViewWidth) / 2
        //父试图左右所留间隙
        let screenSpace = (kScreenWidth - viewWidth) / 2
        if baseLeftX > 0 {
            for index in 0..<number {
                
                let leftX = CGFloat(index) * (space + tfWidth) + (baseLeftX - screenSpace)
                let textf = customerTextfield(frame: CGRect(x: CGFloat(leftX), y: 0, width: tfWidth, height: tfWidth-5))
                textf.keyboardType = .numberPad
                textf.tag = index
                textf.textAlignment = .center
                textf.delegate = self
                textf.deleteDelegate = self
                textf.font = UIFont.systemFont(ofSize: 26, weight: .bold)
                if index == 0 {
                    textf.becomeFirstResponder()
                }
                textfieldArr.append(textf)
                
                let lineV = UIView(frame: CGRect(x: CGFloat(leftX), y: tfWidth, width: tfWidth, height: 5))
                lineV.backgroundColor = .orange
                addSubview(textf)
                addSubview(lineV)
            }
        }else{
            print("输入框过长，超出屏幕范围，请重新设置尺寸")
        }
        
    }
    
    func cleanText() {
        for tf in textfieldArr {
            tf.text = ""
            if tf.tag == 0 {
                tf.becomeFirstResponder()
            }
        }
    }
    
    @objc func textfieldToActive() {
        
        for index in 0..<number {
            if textfieldArr[index].hasText {
                continue
            }else{
                textfieldArr[index].becomeFirstResponder()
                return
            }
        }
    }
}

extension VerificationCodeView: UITextFieldDelegate,customerTextfieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !textField.hasText {
            
            let index = textField.tag
            
            if index == number - 1 {
                textfieldArr[index].text = string
                
                var code = ""
                for tf in textfieldArr {
                    code += tf.text ?? ""
                }
                
                viewDelegate?.verificationCodeDidFinishedInput(verificationCodeView: self, code: code)
                cleanText()
                return false
            }
            
            textfieldArr[index].text = string
            textfieldArr[index + 1].becomeFirstResponder()
        }
        return false
    }
    
    func deleteBackward() {
        for index in 0..<number {
            
            if !textfieldArr[index].isFirstResponder {
                continue
            }
            if index == 0 {
                return
            }
            textfieldArr[index-1].becomeFirstResponder()
            textfieldArr[index-1].text = ""
        }
    }
    
}

protocol customerTextfieldDelegate {
    
    func deleteBackward()
}


class customerTextfield: UITextField {
    
    var deleteDelegate: customerTextfieldDelegate? = nil
    
    override func deleteBackward() {
        super.deleteBackward()
        deleteDelegate?.deleteBackward()
    }
}
