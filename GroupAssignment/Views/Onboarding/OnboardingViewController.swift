//
//  OnboardingViewController.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-04-10.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var paceControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            paceControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(
                title: "Track Your Assignments",
                description: "Never miss a deadline! Keep track of all your assignments in one place",
                image: UIImage(named: "SecondScreen") ?? UIImage()
            ),
            OnboardingSlide(
                title: "Plan Smarter",
                description: "Sort assignments with ease. Stay on top of your workload effortlessly",
                image: UIImage(named: "ThirdScreen") ?? UIImage()
            ),
            OnboardingSlide(
                title: "Stay Organized",
                description: "Monitor progress and get reminders for upcoming due dates.",
                image: UIImage(named: "FourthScreen") ?? UIImage()
            ),
        ]

        collectionView.delegate = self
        collectionView.dataSource = self

        
    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated:true, completion: nil)
            //performSegue(withIdentifier: "goToHome", sender: self)

            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    

}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
        
    }
}
