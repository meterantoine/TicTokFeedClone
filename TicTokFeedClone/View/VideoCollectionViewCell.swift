//
//  VideoCollectionViewCell.swift
//  TicTokFeedClone
//
//  Created by Antoine Perry on 9/2/20.
//  Copyright © 2020 Antoine Perry. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject {
    func didtapProfileButton(with model: VideoModel)
    func didtapLikeButton(with model: VideoModel)
    func didtapCommentButton(with model: VideoModel)
    func didtapSharedButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var player: AVPlayer?
    
    private var model: VideoModel?
    
    private let videoContainer = UIView()
    
    // Delegate
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    // Labels
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let audioTrackLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // Buttons
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapProfileButton), for: .touchUpInside)
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapLikeButton), for: .touchDown)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapCommentButton), for: .touchDown)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didtapSharedButton), for: .touchDown)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoContainer.frame = contentView.bounds
        
        let size = frame.size.width/7
        let height = frame.size.height-100
        let width = frame.size.width
        
        // Buttons
        shareButton.frame = CGRect(x: width-size, y: height-size, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)
        
        // Labels
        audioTrackLabel.frame = CGRect(x: 5, y: height - 30, width:  width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 5, y: height - 80, width:  width-size-10, height: 50)
        usernameLabel.frame = CGRect(x: 5, y: height - 120, width:  width-size-10, height: 50)
    }
    
    override func prepareForReuse() {
        captionLabel.text = nil
        audioTrackLabel.text = nil
        usernameLabel.text = nil
    }
    
    // MARK: - Selectors
    
    @objc func didtapProfileButton() {
        guard let model = model else { return }
        delegate?.didtapProfileButton(with: model)
        print("tapped")
    }
    
    @objc func didtapLikeButton() {
        guard let model = model else { return }
        delegate?.didtapLikeButton(with: model)
    }

    @objc func didtapCommentButton() {
        guard let model = model else { return }
        delegate?.didtapCommentButton(with: model)
    }
    
    @objc func didtapSharedButton() {
        guard let model = model else { return }
        delegate?.didtapSharedButton(with: model)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .red
        contentView.clipsToBounds = true
        
        contentView.addSubview(videoContainer)
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioTrackLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        videoContainer.clipsToBounds = true
        sendSubviewToBack(videoContainer)
    }
    
    public func configure(with model: VideoModel) {
        guard let path = Bundle.main.path(forResource: model.videoFileNme, ofType: model.videoFileFormat) else { return }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 5
        player?.play()
        
        captionLabel.text = model.caption
        audioTrackLabel.text = model.audioTrackname
        usernameLabel.text = model.username
    }

}
