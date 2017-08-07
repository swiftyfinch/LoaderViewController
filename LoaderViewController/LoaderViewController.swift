//
//  LoaderViewController.swift
//
//
//  Created by Vyacheslav Khorkov on 13/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    
    lazy var loader: UIViewType & AnimatedLoading = {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }()

    private lazy var loaderView: UIView = self.loader as! UIView
    private let showAnimationDuration: TimeInterval = 0.2
	private var hiddenViews: [UIView] = []
	
    func beginLoad() {
        hideViews()
		showLoader()
    }
    
    func endLoad() {
		if !hideLoader() { return }
		showViews()
    }
    
    private func showLoader() {
        view.addSubview(loaderView)
		
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        [loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         loaderView.widthAnchor.constraint(equalToConstant: loaderView.bounds.width),
         loaderView.heightAnchor.constraint(equalToConstant: loaderView.bounds.height)]
            .forEach { $0.isActive = true }
        
        loaderView.isHidden = false
        loader.startAnimating()
    }
    
    @discardableResult private func hideLoader() -> Bool {
		loader.stopAnimating()
		if loaderView.superview == nil { return false }
        loaderView.removeFromSuperview()
		return true
    }
	
	private func hideViews() {
		hiddenViews = view.subviews.filter { !$0.isHidden }
		hiddenViews.forEach { $0.isHidden = true }
	}
	
	private func showViews() {
		let views = hiddenViews.filter { $0.isHidden }
		hiddenViews.removeAll()
		views.forEach {
			$0.alpha = 0.0
			$0.isHidden = false
		}
		
		UIView.animate(withDuration: showAnimationDuration) {
			views.forEach { $0.alpha = 1.0 }
		}
	}
	
}
