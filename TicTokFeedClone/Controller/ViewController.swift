//
//  ViewController.swift
//  TicTokFeedClone
//
//  Created by Antoine Perry on 9/2/20.
//  Copyright © 2020 Antoine Perry. All rights reserved.
//

import UIKit

let cellreuseIdentifier = "VideoCollectionViewCell"

class ViewController: UIViewController{
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        createVideoModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    // MARK: - Helper Functions
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellreuseIdentifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    func createVideoModel() {
        for _ in 0..<10 {
            let model = VideoModel(caption: "Whats your name?", username: "@meterantoine", audioTrackname: "Youtube", videoFileNme: "videoplayback", videoFileFormat: "mp4")
            data.append(model)
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellreuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension ViewController: VideoCollectionViewCellDelegate {
    func didtapProfileButton(with model: VideoModel) {
        print("Debug: Profile button tapped.")
    }
    
    func didtapLikeButton(with model: VideoModel) {
        print("Debug: Like button tapped.")
    }
    
    func didtapCommentButton(with model: VideoModel) {
        print("Debug: Comment button tapped.")
    }
    
    func didtapSharedButton(with model: VideoModel) {
        print("Debug: Shared button tapped.")
    }
    
    
}

