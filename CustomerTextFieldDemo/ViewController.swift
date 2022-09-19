//
//  ViewController.swift
//  CustomerTextFieldDemo
//
//  Created by 刘圣洁 on 2022/9/17.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
class ViewController: UIViewController {

    var textLabel: UILabel = UILabel()
    
    lazy var verificationCodeView: VerificationCodeView = {
        let verificationCodeView = VerificationCodeView(frame: CGRect(x: 20, y: 52, width: kScreenWidth - 40, height: 50),space: 10,tfWidth: 50,number: 4,viewWidth: kScreenWidth - 32)
        verificationCodeView.viewDelegate = self
        return verificationCodeView
    }()
    
    lazy var overLayView: UIView = {
        let overLayView = UIView(frame: CGRect(x: 20, y: 52, width: kScreenWidth - 40, height: 50))
        overLayView.backgroundColor = .clear
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(textfieldToActive))
        overLayView.addGestureRecognizer(tapgesture)
        return overLayView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController {
    
    func setupUI() {
        view.addSubview(self.verificationCodeView)
        view.addSubview(self.overLayView)
        
        textLabel = UILabel(frame: CGRect(x: 20, y: 200, width: kScreenWidth - 40, height: 30))
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
    }
    
    @objc func textfieldToActive() {
        verificationCodeView.textfieldToActive()
    }
}

extension ViewController: VerificationCodeViewDelegate {
    func verificationCodeDidFinishedInput(verificationCodeView: VerificationCodeView, code: String) {
        textLabel.text = code
    }
}
