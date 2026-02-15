//
//  LunchScreenViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/02/18.
//

import UIKit
import SOTabBar

class LunchScreenViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

                //imageView作成
                self.logoImageView = UIImageView(frame: CGRectMake(0, 0, 204, 77))
                //画面centerに
                self.logoImageView.center = self.view.center
                //logo設定
                self.logoImageView.image = UIImage(named: "icon.jpg")
                //viewに追加
                self.view.addSubview(self.logoImageView)
        
        /*
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timetable")
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "list")
               
        firstVC.tabBarItem = UITabBarItem(title: "時間割", image: UIImage(named: "icons8-時間とともに-50.png"), selectedImage: UIImage(named: "icons8-時間とともに-50.png"))
        secondVC.tabBarItem = UITabBarItem(title: "課題", image: UIImage(named: "icons8-タスクリスト-50.png"), selectedImage: UIImage(named: "icons8-タスクリスト-50.png"))
            
        //viewControllers = [firstVC, secondVC]
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewContorller = storyboard.instantiateViewController(withIdentifier: "mainViewController")
        nextViewContorller.modalPresentationStyle = .fullScreen
        self.present(nextViewContorller, animated: true)
        
        UIView.animate(withDuration: 1.2,
                       delay: 4.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                    animations: { () in
            self.logoImageView.transform = CGAffineTransformMakeScale(3.6, 3.6)
                    }, completion: { (Bool) in

                })

                //拡大させて、消えるアニメーション
        UIView.animate(withDuration: 0.8,
                       delay: 5.2,
                       options: UIView.AnimationOptions.curveEaseOut,
                    animations: { () in
            self.logoImageView.transform = CGAffineTransformMakeScale(4.8, 4.8)
                        self.logoImageView.alpha = 0
                    }, completion: { (Bool) in
                        self.logoImageView.removeFromSuperview()
                })
    }

}
