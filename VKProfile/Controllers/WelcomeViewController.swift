//
//  WelcomeViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class WelcomeViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers = [
        self.createWelcomeViewController(with: "Мгновенные сообщения", and: #imageLiteral(resourceName: "message")),
        self.createWelcomeViewController(with: "Новостная лента", and: #imageLiteral(resourceName: "news")),
        self.createWelcomeViewController(with: "Игры для всех", and: #imageLiteral(resourceName: "game"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    private func createWelcomeViewController(with title: String, and image: UIImage) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomePageVC = storyboard.instantiateViewController(withIdentifier: "welcomeViewController") as! WelcomePageViewController
        welcomePageVC.titleText = title
        welcomePageVC.image = image
        return welcomePageVC
    }
}

extension WelcomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else { return nil }
        
        guard orderedViewControllersCount >  nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else { return 0 }
        
        return firstViewControllerIndex
    }
    
}
