//
//  IntroVC.swift
//  Terhal
//
//  Created by mahroUS on 2/9/1441 AH.
//  Copyright © 1441 AH mahroUS. All rights reserved.
//
//


import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagee: UIPageControl!
    
    var count = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showNextItemCollectionViewOnClick(_ sender: Any) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        
        var minItem: NSIndexPath = visibleItems.object(at: 0) as! NSIndexPath
        for itr in visibleItems {
            
            if minItem.row > (itr as AnyObject).row {
                minItem = itr as! NSIndexPath
            }
        }
        
        let nextItem = NSIndexPath(row: minItem.row + 1, section: 0)
        self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .left, animated: true)
        
    }
    @IBAction func showBacktemCollectionViewOnClick(_ sender: Any) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        
        var minItem: NSIndexPath = visibleItems.object(at: 0) as! NSIndexPath
        for itr in visibleItems {
            
            if minItem.row > (itr as AnyObject).row {
                minItem = itr as! NSIndexPath
            }
        }
        
        let nextItem = NSIndexPath(row: minItem.row - 1, section: 0)
        self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .right, animated: true)
        
    }
    
    @IBAction func moveToLogin(_ sender: Any) {
        let go = storyboard?.instantiateViewController(withIdentifier: "logInVc") as! logInVc
        present(go, animated: true)
        
        
    }
  
    @IBAction func loginBtn(_ sender: Any) {
        
        appDelegate.setRoot(storyBoard: .authentication,vc: .login)

    }
    
}




extension IntroVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroCell
       
        if indexPath.row != 2{
            cell.nextBtn.addTarget(self, action: #selector(showNextItemCollectionViewOnClick), for: .touchUpInside)
        }else{
            cell.nextBtn.addTarget(self, action: #selector(moveToLogin), for: .touchUpInside)
        }
        
        if indexPath.row == 0{
             cell.backBtn.addTarget(self, action: #selector(showBacktemCollectionViewOnClick(_:)), for: .touchUpInside)
            cell.iconImg.image = #imageLiteral(resourceName: "01-onboarding")
            cell.titleLb.text = "For Teacher".localized
            cell.desTV.text = "Student Application Give Teacher To Add Exams , Documents , Absents and put groups Time Schedules To His Students".localized
            cell.pageControl.currentPage = 0
            cell.nextBtn.isHidden = false
            cell.backBtn.isHidden = true
            cell.styleBtn.isHidden = true
            count = 0
            
        }
        else if indexPath.row == 1{
              cell.backBtn.addTarget(self, action: #selector(showBacktemCollectionViewOnClick(_:)), for: .touchUpInside)
            cell.iconImg.image = #imageLiteral(resourceName: "03-onboarding")

            cell.titleLb.text = "For Parent".localized
            cell.desTV.text = "Student Application Give Parent To Follow His Childern About Absents and Exams and Notes of Teachers about His Childern".localized
            cell.pageControl.currentPage = 1
            cell.nextBtn.isHidden = false
            cell.backBtn.isHidden = false
            cell.styleBtn.isHidden = true

        }
        else if indexPath.row == 2{
              cell.backBtn.addTarget(self, action: #selector(showBacktemCollectionViewOnClick(_:)), for: .touchUpInside)
            cell.iconImg.image = #imageLiteral(resourceName: "bg")

            cell.titleLb.text = "For Student".localized
            cell.desTV.text = "Student Application Give Student To Search About Teachers , Rate Them , Solve Exams At Application and revise Documents Which Teacher Sent".localized
            cell.pageControl.currentPage = 2
            cell.nextBtn.isHidden = true
            cell.backBtn.isHidden = false
            cell.styleBtn.addTarget(self, action: #selector(loginBtn(_:)), for: .touchUpInside)
            cell.hiddenConstrain.isActive = false
            cell.viewConstrain.isActive = true
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        
        size = CGSize(width: self.view.frame.width  , height: self.view.frame.height + 46)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
