//
//  AddPhotoViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit
import Nuke
import SwiftyJSON

class NewPhotoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cstHeightForContentView: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWhatsNew: UILabel!
    @IBOutlet weak var imvNewPhoto: UIImageView!
    @IBOutlet weak var cstHeightImvNewPhoto: NSLayoutConstraint!
    @IBOutlet weak var imvAvatarAuthor: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblAuthorSigned: UILabel!
    @IBOutlet weak var vwBrowseAll: UIView!
    @IBOutlet weak var lblBrowseAll: UILabel!
    @IBOutlet weak var leftClvPhotos: UICollectionView!
    @IBOutlet weak var rightClvPhotos: UICollectionView!
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var cstBottomScrollview: NSLayoutConstraint!
    
    var photos: [PhotoModel] = []
    
    var leftPhotos: [PhotoModel] = []
    
    var rightPhotos: [PhotoModel] = []
    
    let cellWidth: CGFloat = (ScreenSize.WIDTH - 32 - 9)/2 // 32: Leading - Trailing, 9: spacing, 2: 2 line vertical
    
    let lineSpacing: CGFloat = 9.0
    
    let loadMoreViewHeight: CGFloat = 52 + 32
    
    var currentPage: Int = 0 {
        didSet {
            createTempData(page: currentPage)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewImage()
        configureView()
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        leftClvPhotos.reloadData()
        rightClvPhotos.reloadData()
    }
    
    private func createTempData(page: Int = 0) {
        let dict = Utils.parseJsonFromFile(filename: "Photos")
        for (_, photoData): (String, JSON) in dict["data"] {
            let photo = PhotoModel(data: photoData)
            photos.append(photo)
            let leftClvContentHeight = calculateContentSizeHeight(collectionView: leftClvPhotos, photos: leftPhotos)
            let rightClvContentHeight = calculateContentSizeHeight(collectionView: rightClvPhotos, photos: rightPhotos)
            if leftClvContentHeight < rightClvContentHeight {
                leftPhotos.append(photo)
            } else {
                rightPhotos.append(photo)
            }
        }
        let leftClvContentSize = calculateContentSizeHeight(collectionView: leftClvPhotos, photos: leftPhotos)
        let rightClvContentSize = calculateContentSizeHeight(collectionView: rightClvPhotos, photos: rightPhotos)
        cstHeightForContentView.constant = vwBrowseAll.frame.origin.y + CGFloat.tabbarHeight + loadMoreViewHeight + max(leftClvContentSize, rightClvContentSize)
        self.view.layoutIfNeeded()
        leftClvPhotos.reloadData()
        rightClvPhotos.reloadData()
    }
    
    private func calculateContentSizeHeight(collectionView: UICollectionView, photos: [PhotoModel]) -> CGFloat {
        var height:CGFloat = 0.0
        for photo in photos {
            height += cellWidth * CGFloat(photo.height)/CGFloat(photo.width) + lineSpacing
        }
        return height
    }
    
    private func configureView() {
        cstBottomScrollview.constant = CGFloat.tabbarHeight
        scrollView.delaysContentTouches = false
        
        imvAvatarAuthor.circular()
        
        leftClvPhotos.delegate = self
        leftClvPhotos.dataSource = self
        leftClvPhotos.register(UINib(nibName: CollectionViewCellName.photo, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellName.photo)
        
        rightClvPhotos.delegate = self
        rightClvPhotos.dataSource = self
        rightClvPhotos.register(UINib(nibName: CollectionViewCellName.photo, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellName.photo)
        
        lblTitle.font = UIFont.titleFont
        lblTitle.addCharacterSpacing(kernValue: .kernTitleValue)
        
        lblAuthorName.font = .lblName
        lblAuthorName.textColor = .lblNameColor
        lblAuthorSigned.font = .lblSubName
        lblAuthorSigned.textColor = .lblSubnameColor
        
        lblWhatsNew.font = UIFont.sectionTitleFont
        lblWhatsNew.addCharacterSpacing(kernValue: .kernTitleValue)
        
        lblBrowseAll.font = UIFont.sectionTitleFont
        lblBrowseAll.addCharacterSpacing(kernValue: .kernTitleValue)
        
        btnSeeMore.titleLabel?.font = UIFont.btnTitleFont
        btnSeeMore.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnSeeMore.setTitleColor(.lightBtnTextColor, for: .normal)
        btnSeeMore.borderWidth = .borderWidth
        btnSeeMore.borderColor = .borderColor
        
        loadText()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.loadText),
            name: Notification.Name(NotificationName.changedLanguages),
            object: nil)
    }
    
    @objc private func loadText() {
        lblTitle.text = "Discover".localized()
        lblWhatsNew.text = "What's new today".localized().uppercased()
        lblBrowseAll.text = "Browse all".localized().uppercased()
        btnSeeMore.setTitle("See more".localized().uppercased(), for: .normal)
    }
    
    private func loadNewImage() {
        // Data test
        var newPhoto = PhotoModel(width: 512, height: 512, url: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")
        let author = Author(name: "Thanh Bui", signature: "@cthanh2307", avatar: "https://homepages.cae.wisc.edu/~ece533/images/baboon.png")
        newPhoto.author = author
        
        lblAuthorName.text = newPhoto.author.name
        lblAuthorSigned.text = newPhoto.author.signature
        
        self.loadImage(from: newPhoto.url, to: self.imvNewPhoto)
        self.loadImage(from: newPhoto.author.avatar, to: self.imvAvatarAuthor)
        self.cstHeightImvNewPhoto.constant = CGFloat(newPhoto.height/newPhoto.width) * imvNewPhoto.bounds.size.width
        self.view.layoutIfNeeded()
        cstHeightForContentView.constant = vwBrowseAll.frame.origin.y + CGFloat.tabbarHeight + loadMoreViewHeight
    }
    
    @IBAction func onActionSeeMore(_ sender: Any) {
        currentPage += 1
    }
    
    private func loadImage(from url: String, to imageView: UIImageView) {
        if let url = URL(string: url) {
            
            let request = Nuke.ImageRequest(url: url)
            
            let options = ImageLoadingOptions(
                placeholder: UIImage.placeholderImage,
                transition: .fadeIn(duration: 0.33)
                
            )
            Nuke.loadImage(with: request, options: options, into: imageView)
        }
    }

}

extension NewPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == leftClvPhotos {
            return leftPhotos.count
        } else { // Right Clv
            return rightPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellName.photo, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == leftClvPhotos {
            self.loadImage(from: leftPhotos[indexPath.item].url, to: cell.imvPhoto)
        } else { // Right Clv
            self.loadImage(from: rightPhotos[indexPath.item].url, to: cell.imvPhoto)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftClvContentSize = calculateContentSizeHeight(collectionView: leftClvPhotos, photos: leftPhotos)
        let rightClvContentSize = calculateContentSizeHeight(collectionView: rightClvPhotos, photos: rightPhotos)
        if leftClvContentSize < rightClvContentSize {
            if collectionView == leftClvPhotos && indexPath.row == leftPhotos.count - 1 {
                return CGSize(width: min(cellWidth, collectionView.bounds.size.width), height: min(cellWidth, collectionView.bounds.size.width) * CGFloat(leftPhotos.last!.height)/CGFloat(leftPhotos.last!.width) + (rightClvContentSize - leftClvContentSize))
            }
        } else {
            if collectionView == rightClvPhotos && indexPath.row == rightPhotos.count - 1 {
                return CGSize(width: min(cellWidth, collectionView.bounds.size.width), height: min(cellWidth, collectionView.bounds.size.width) * CGFloat(rightPhotos.last!.height)/CGFloat(rightPhotos.last!.width) + (leftClvContentSize - rightClvContentSize))
            }
        }
        if collectionView == leftClvPhotos {
            let photo = leftPhotos[indexPath.item]
            return CGSize(width: min(cellWidth, collectionView.bounds.size.width), height: min(cellWidth, collectionView.bounds.size.width) * CGFloat(photo.height)/CGFloat(photo.width))
        } else { // Right clv
            let photo = rightPhotos[indexPath.item]
            return CGSize(width: min(cellWidth, collectionView.bounds.size.width), height: min(cellWidth, collectionView.bounds.size.width) * CGFloat(photo.height)/CGFloat(photo.width))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}


