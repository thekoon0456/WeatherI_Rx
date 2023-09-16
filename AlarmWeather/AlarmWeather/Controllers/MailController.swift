//
//  MailController.swift
//  AlarmWeather
//
//  Created by Deokhun KIM on 2023/09/16.
//

import Foundation
import MessageUI

//MARK: - MessageUI 이메일

extension SettingController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setToRecipients(["thekoon0456@gmail.com"]) // 수신자 이메일 주소
            mailController.setSubject("[날씨의 i] 피드백입니다.") // 이메일 제목
            mailController.setMessageBody("다양한 의견을 보내주시면 앱을 만드는데 큰 보탬이 됩니다. 감사합니다.", isHTML: false) // 이메일 내용
            
            present(mailController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(
            title: "메일 전송 실패",
            message: "이메일 설정을 확인하고 다시 시도해주세요.",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { action in print("확인") }
        sendMailErrorAlert.addAction(confirmAction)
        
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("이메일 보내기 취소")
        case .sent:
            print("이메일 보내기 성공")
        case .saved:
            print("이메일이 저장되었습니다.")
        case .failed:
            print("이메일 보내기 실패")
        @unknown default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
